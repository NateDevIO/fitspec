using Dapper;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;

namespace FitSpec.Data.Repositories;

public class InventoryRepository : IInventoryRepository
{
    private readonly IDapperConnectionFactory _connectionFactory;

    public InventoryRepository(IDapperConnectionFactory connectionFactory)
    {
        _connectionFactory = connectionFactory;
    }

    public async Task<List<InventoryStatusDto>> GetInventoryStatusAsync(int[] productIds)
    {
        using var connection = _connectionFactory.CreateConnection();
        // Use a deterministic stock simulation based on product ID
        var results = await connection.QueryAsync<InventoryStatusDto>(
            @"SELECT p.Id AS ProductId,
                     CASE
                       WHEN p.Id % 7 = 0 THEN 0
                       WHEN p.Id % 5 = 0 THEN ABS(CHECKSUM(p.Id * 13)) % 5 + 1
                       ELSE ABS(CHECKSUM(p.Id * 17)) % 50 + 10
                     END AS StockQuantity,
                     CASE
                       WHEN p.Id % 7 = 0 THEN 'out_of_stock'
                       WHEN p.Id % 5 = 0 THEN 'low_stock'
                       ELSE 'in_stock'
                     END AS Status
              FROM Products p
              WHERE p.Id IN @ProductIds",
            new { ProductIds = productIds });
        return results.ToList();
    }

    public async Task<InventoryStatusDto?> GetProductInventoryAsync(int productId)
    {
        var results = await GetInventoryStatusAsync(new[] { productId });
        return results.FirstOrDefault();
    }
}
