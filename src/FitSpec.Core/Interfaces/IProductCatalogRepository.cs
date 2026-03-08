using FitSpec.Core.Entities;

namespace FitSpec.Core.Interfaces;

public interface IProductCatalogRepository
{
    Task<ProductCatalogExtended?> GetExtendedSpecsAsync(int productId);
}
