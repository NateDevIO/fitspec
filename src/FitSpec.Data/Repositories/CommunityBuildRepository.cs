using Dapper;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;

namespace FitSpec.Data.Repositories;

public class CommunityBuildRepository : ICommunityBuildRepository
{
    private readonly IDapperConnectionFactory _connectionFactory;

    public CommunityBuildRepository(IDapperConnectionFactory connectionFactory)
    {
        _connectionFactory = connectionFactory;
    }

    public async Task<List<PopularProductDto>> GetPopularProductsAsync(int vehicleId, int count = 8)
    {
        using var connection = _connectionFactory.CreateConnection();
        var results = await connection.QueryAsync<PopularProductDto>(
            @"SELECT TOP (@Count)
                p.Id AS ProductId, p.Name, p.Brand, p.Price, p.ImageUrl,
                c.Name AS CategoryName,
                COUNT(oi.Id) AS InstallCount
              FROM Products p
              INNER JOIN FitmentMappings fm ON fm.ProductId = p.Id
              INNER JOIN Categories c ON p.CategoryId = c.Id
              LEFT JOIN OrderItems oi ON oi.ProductId = p.Id
              WHERE fm.VehicleId = @VehicleId
              GROUP BY p.Id, p.Name, p.Brand, p.Price, p.ImageUrl, c.Name
              ORDER BY InstallCount DESC, p.Name",
            new { VehicleId = vehicleId, Count = count });
        return results.ToList();
    }
}
