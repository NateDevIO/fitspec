using System.Data;
using Dapper;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;

namespace FitSpec.Data.Repositories;

public class ProductRepository : IProductRepository
{
    private readonly IDapperConnectionFactory _connectionFactory;

    public ProductRepository(IDapperConnectionFactory connectionFactory)
    {
        _connectionFactory = connectionFactory;
    }

    public async Task<PagedResult<ProductSummaryDto>> GetCompatibleProductsAsync(int vehicleId, ProductFilterParams filters)
    {
        using var connection = _connectionFactory.CreateConnection();
        var parameters = new DynamicParameters();
        parameters.Add("VehicleId", vehicleId);
        parameters.Add("CategoryId", filters.CategoryId);
        parameters.Add("Brand", filters.Brand);
        parameters.Add("MinPrice", filters.MinPrice);
        parameters.Add("MaxPrice", filters.MaxPrice);
        parameters.Add("MaxDifficulty", filters.MaxDifficulty);
        parameters.Add("VerifiedOnly", filters.VerifiedOnly);
        parameters.Add("SortBy", filters.Sort);
        parameters.Add("PageNumber", filters.Page);
        parameters.Add("PageSize", filters.PageSize);
        parameters.Add("TotalCount", dbType: DbType.Int32, direction: ParameterDirection.Output);

        var items = await connection.QueryAsync<ProductSummaryDto>(
            "sp_GetCompatibleProducts",
            parameters,
            commandType: CommandType.StoredProcedure);

        var totalCount = parameters.Get<int>("TotalCount");

        return new PagedResult<ProductSummaryDto>
        {
            Items = items.ToList(),
            TotalCount = totalCount,
            Page = filters.Page,
            PageSize = filters.PageSize
        };
    }

    public async Task<ProductDetailDto?> GetProductByIdAsync(int productId)
    {
        using var connection = _connectionFactory.CreateConnection();
        return await connection.QuerySingleOrDefaultAsync<ProductDetailDto>(
            @"SELECT p.Id, p.SKU, p.Name, p.Description, p.Brand, p.Price,
                     p.ImageUrl, p.CategoryId, c.Name AS CategoryName,
                     p.IsVerified, p.Weight, p.CreatedAt
              FROM Products p
              INNER JOIN Categories c ON p.CategoryId = c.Id
              WHERE p.Id = @ProductId",
            new { ProductId = productId });
    }

    public async Task<CompatibilityCheckDto?> CheckCompatibilityAsync(int productId, int vehicleId)
    {
        using var connection = _connectionFactory.CreateConnection();
        return await connection.QuerySingleOrDefaultAsync<CompatibilityCheckDto>(
            @"SELECT CAST(1 AS BIT) AS IsCompatible,
                     fm.InstallDifficulty, fm.FitmentNotes, fm.IsVerified
              FROM FitmentMappings fm
              WHERE fm.ProductId = @ProductId AND fm.VehicleId = @VehicleId",
            new { ProductId = productId, VehicleId = vehicleId });
    }

    public async Task<List<ProductDetailDto>> GetProductsByIdsAsync(int[] ids)
    {
        using var connection = _connectionFactory.CreateConnection();
        var results = await connection.QueryAsync<ProductDetailDto>(
            @"SELECT p.Id, p.SKU, p.Name, p.Description, p.Brand, p.Price,
                     p.ImageUrl, p.CategoryId, c.Name AS CategoryName,
                     p.IsVerified, p.Weight, p.CreatedAt
              FROM Products p
              INNER JOIN Categories c ON p.CategoryId = c.Id
              WHERE p.Id IN @Ids",
            new { Ids = ids });
        return results.ToList();
    }

    public async Task<List<ProductSummaryDto>> GetRelatedProductsAsync(int productId, int? vehicleId)
    {
        using var connection = _connectionFactory.CreateConnection();

        string sql;
        object parameters;

        if (vehicleId.HasValue)
        {
            // Find products in OTHER categories that are compatible with the same vehicle.
            // Use ROW_NUMBER per category with HASHBYTES for good per-product variation.
            sql = @";WITH Ranked AS (
                        SELECT p.Id, p.SKU, p.Name, p.Brand, p.Price, p.ImageUrl,
                               c.Name AS CategoryName, fm.InstallDifficulty, p.IsVerified,
                               CAST(NULL AS FLOAT) AS AverageRating,
                               ROW_NUMBER() OVER (
                                   PARTITION BY p.CategoryId
                                   ORDER BY CHECKSUM(HASHBYTES('MD5', CONCAT(p.Id, '-', @ProductId)))
                               ) AS RowInCat
                        FROM Products p
                        INNER JOIN Categories c ON p.CategoryId = c.Id
                        INNER JOIN FitmentMappings fm ON fm.ProductId = p.Id AND fm.VehicleId = @VehicleId
                        WHERE p.CategoryId <> (SELECT CategoryId FROM Products WHERE Id = @ProductId)
                          AND p.Id <> @ProductId
                    )
                    SELECT TOP 8 Id, SKU, Name, Brand, Price, ImageUrl,
                           CategoryName, InstallDifficulty, IsVerified, AverageRating
                    FROM Ranked
                    WHERE RowInCat <= 2
                    ORDER BY RowInCat, CHECKSUM(HASHBYTES('MD5', CONCAT(Id, '-', @ProductId)))";
            parameters = new { ProductId = productId, VehicleId = vehicleId.Value };
        }
        else
        {
            // Find products in complementary categories (no vehicle context).
            // Use ROW_NUMBER per category with HASHBYTES for good per-product variation.
            sql = @";WITH Ranked AS (
                        SELECT p.Id, p.SKU, p.Name, p.Brand, p.Price, p.ImageUrl,
                               c.Name AS CategoryName, 0 AS InstallDifficulty, p.IsVerified,
                               CAST(NULL AS FLOAT) AS AverageRating,
                               ROW_NUMBER() OVER (
                                   PARTITION BY p.CategoryId
                                   ORDER BY CHECKSUM(HASHBYTES('MD5', CONCAT(p.Id, '-', @ProductId)))
                               ) AS RowInCat
                        FROM Products p
                        INNER JOIN Categories c ON p.CategoryId = c.Id
                        WHERE p.CategoryId <> (SELECT CategoryId FROM Products WHERE Id = @ProductId)
                          AND p.Id <> @ProductId
                    )
                    SELECT TOP 8 Id, SKU, Name, Brand, Price, ImageUrl,
                           CategoryName, InstallDifficulty, IsVerified, AverageRating
                    FROM Ranked
                    WHERE RowInCat <= 2
                    ORDER BY RowInCat, CHECKSUM(HASHBYTES('MD5', CONCAT(Id, '-', @ProductId)))";
            parameters = new { ProductId = productId };
        }

        var results = await connection.QueryAsync<ProductSummaryDto>(sql, parameters);
        return results.ToList();
    }
}
