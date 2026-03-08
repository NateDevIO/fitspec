using System.Data;
using Dapper;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;

namespace FitSpec.Data.Repositories;

public class AdminRepository : IAdminRepository
{
    private readonly IDapperConnectionFactory _connectionFactory;

    public AdminRepository(IDapperConnectionFactory connectionFactory)
    {
        _connectionFactory = connectionFactory;
    }

    public async Task<AdminOverviewDto> GetOverviewAsync()
    {
        using var connection = _connectionFactory.CreateConnection();
        return await connection.QuerySingleAsync<AdminOverviewDto>(
            @"SELECT
                (SELECT COUNT(*) FROM Products) AS TotalProducts,
                (SELECT COUNT(*) FROM Orders) AS TotalOrders,
                (SELECT ISNULL(SUM(TotalAmount), 0) FROM Orders) AS TotalRevenue,
                0 AS TotalReviews,
                (SELECT COUNT(*) FROM Vehicles) AS TotalVehicles,
                (SELECT COUNT(*) FROM FitmentMappings) AS TotalFitmentMappings");
    }

    public async Task<List<OrdersByMonthDto>> GetOrdersByMonthAsync(int months = 12)
    {
        using var connection = _connectionFactory.CreateConnection();
        var results = await connection.QueryAsync<OrdersByMonthDto>(
            @"SELECT TOP (@Months)
                FORMAT(o.OrderDate, 'yyyy-MM') AS Month,
                COUNT(*) AS OrderCount,
                SUM(o.TotalAmount) AS Revenue
              FROM Orders o
              GROUP BY FORMAT(o.OrderDate, 'yyyy-MM')
              ORDER BY Month DESC",
            new { Months = months });
        return results.Reverse().ToList();
    }

    public async Task<List<TopProductDto>> GetTopProductsAsync(int count = 10)
    {
        using var connection = _connectionFactory.CreateConnection();
        var results = await connection.QueryAsync<TopProductDto>(
            @"SELECT TOP (@Count)
                p.Id AS ProductId, p.Name, p.Brand,
                COUNT(oi.Id) AS OrderCount,
                SUM(oi.UnitPrice * oi.Quantity) AS Revenue
              FROM Products p
              INNER JOIN OrderItems oi ON oi.ProductId = p.Id
              GROUP BY p.Id, p.Name, p.Brand
              ORDER BY OrderCount DESC",
            new { Count = count });
        return results.ToList();
    }

    public async Task<PagedResult<AdminProductDto>> GetProductsAsync(int page = 1, int pageSize = 20, string? search = null)
    {
        using var connection = _connectionFactory.CreateConnection();
        var searchTerm = search != null ? $"%{search}%" : null;

        var totalCount = await connection.ExecuteScalarAsync<int>(
            @"SELECT COUNT(*) FROM Products p
              WHERE @Search IS NULL OR p.Name LIKE @Search OR p.SKU LIKE @Search OR p.Brand LIKE @Search",
            new { Search = searchTerm });

        var items = await connection.QueryAsync<AdminProductDto>(
            @"SELECT p.Id, p.SKU, p.Name, p.Description, p.Brand, p.Price,
                     p.ImageUrl, p.CategoryId, c.Name AS CategoryName,
                     p.IsVerified, p.Weight, p.CreatedAt,
                     (SELECT COUNT(*) FROM FitmentMappings fm WHERE fm.ProductId = p.Id) AS FitmentCount
              FROM Products p
              INNER JOIN Categories c ON p.CategoryId = c.Id
              WHERE @Search IS NULL OR p.Name LIKE @Search OR p.SKU LIKE @Search OR p.Brand LIKE @Search
              ORDER BY p.Name
              OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY",
            new { Search = searchTerm, Offset = (page - 1) * pageSize, PageSize = pageSize });

        return new PagedResult<AdminProductDto>
        {
            Items = items.ToList(),
            TotalCount = totalCount,
            Page = page,
            PageSize = pageSize
        };
    }

    public async Task<int> CreateProductAsync(ProductCreateDto product)
    {
        using var connection = _connectionFactory.CreateConnection();
        return await connection.ExecuteScalarAsync<int>(
            @"INSERT INTO Products (SKU, Name, Description, Brand, Price, ImageUrl, CategoryId, IsVerified, Weight, CreatedAt)
              VALUES (@SKU, @Name, @Description, @Brand, @Price, @ImageUrl, @CategoryId, @IsVerified, @Weight, GETUTCDATE());
              SELECT SCOPE_IDENTITY();",
            product);
    }

    public async Task<bool> UpdateProductAsync(int id, ProductCreateDto product)
    {
        using var connection = _connectionFactory.CreateConnection();
        var rows = await connection.ExecuteAsync(
            @"UPDATE Products SET SKU = @SKU, Name = @Name, Description = @Description,
                     Brand = @Brand, Price = @Price, ImageUrl = @ImageUrl,
                     CategoryId = @CategoryId, IsVerified = @IsVerified, Weight = @Weight
              WHERE Id = @Id",
            new { Id = id, product.SKU, product.Name, product.Description, product.Brand, product.Price, product.ImageUrl, product.CategoryId, product.IsVerified, product.Weight });
        return rows > 0;
    }

    public async Task<bool> DeleteProductAsync(int id)
    {
        using var connection = _connectionFactory.CreateConnection();
        var rows = await connection.ExecuteAsync("DELETE FROM Products WHERE Id = @Id", new { Id = id });
        return rows > 0;
    }
}
