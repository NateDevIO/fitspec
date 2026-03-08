using System.Data;
using Dapper;
using FitSpec.Core.DTOs;
using FitSpec.Core.Entities;
using FitSpec.Core.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace FitSpec.Data.Repositories;

public class CategoryRepository : ICategoryRepository
{
    private readonly FitSpecDbContext _context;
    private readonly IDapperConnectionFactory _connectionFactory;

    public CategoryRepository(FitSpecDbContext context, IDapperConnectionFactory connectionFactory)
    {
        _context = context;
        _connectionFactory = connectionFactory;
    }

    public async Task<IEnumerable<CategoryDto>> GetCategoryTreeAsync()
    {
        var categories = await _context.Categories
            .AsNoTracking()
            .OrderBy(c => c.SortOrder)
            .ToListAsync();

        return BuildTree(categories, null);
    }

    public async Task<IEnumerable<CategoryBreakdownDto>> GetCategoryBreakdownAsync(int vehicleId)
    {
        using var connection = _connectionFactory.CreateConnection();
        return await connection.QueryAsync<CategoryBreakdownDto>(
            "sp_GetCategoryBreakdown",
            new { VehicleId = vehicleId },
            commandType: CommandType.StoredProcedure);
    }

    private static List<CategoryDto> BuildTree(List<Category> all, int? parentId)
    {
        return all
            .Where(c => c.ParentCategoryId == parentId)
            .Select(c => new CategoryDto(
                c.Id,
                c.Name,
                c.Slug,
                c.Icon,
                c.ParentCategoryId,
                BuildTree(all, c.Id)))
            .ToList();
    }
}
