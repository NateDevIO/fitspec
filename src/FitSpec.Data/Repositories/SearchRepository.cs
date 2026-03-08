using Dapper;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;

namespace FitSpec.Data.Repositories;

public class SearchRepository : ISearchRepository
{
    private readonly IDapperConnectionFactory _connectionFactory;

    public SearchRepository(IDapperConnectionFactory connectionFactory)
    {
        _connectionFactory = connectionFactory;
    }

    public async Task<List<SearchResultDto>> SearchAsync(string query, int limit = 10)
    {
        using var connection = _connectionFactory.CreateConnection();
        var searchTerm = $"%{query}%";

        var products = await connection.QueryAsync<SearchResultDto>(
            @"SELECT TOP (@Limit)
                'product' AS Type, p.Id, p.Name AS Title,
                p.Brand AS Subtitle, p.ImageUrl, p.Price
              FROM Products p
              WHERE p.Name LIKE @Term OR p.SKU LIKE @Term OR p.Brand LIKE @Term
              ORDER BY
                CASE WHEN p.Name LIKE @ExactTerm THEN 0
                     WHEN p.Brand LIKE @ExactTerm THEN 1
                     ELSE 2 END,
                p.Name",
            new { Limit = limit, Term = searchTerm, ExactTerm = $"{query}%" });

        return products.ToList();
    }
}
