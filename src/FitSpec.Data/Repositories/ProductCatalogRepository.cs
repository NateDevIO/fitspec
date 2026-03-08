using FitSpec.Core.Entities;
using FitSpec.Core.Interfaces;
using MongoDB.Driver;

namespace FitSpec.Data.Repositories;

public class ProductCatalogRepository : IProductCatalogRepository
{
    private readonly MongoDbContext _context;

    public ProductCatalogRepository(MongoDbContext context)
    {
        _context = context;
    }

    public async Task<ProductCatalogExtended?> GetExtendedSpecsAsync(int productId)
    {
        return await _context.CatalogExtended
            .Find(c => c.ProductId == productId)
            .FirstOrDefaultAsync();
    }
}
