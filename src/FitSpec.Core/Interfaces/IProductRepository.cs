using FitSpec.Core.DTOs;

namespace FitSpec.Core.Interfaces;

public interface IProductRepository
{
    Task<PagedResult<ProductSummaryDto>> GetCompatibleProductsAsync(int vehicleId, ProductFilterParams filters);
    Task<ProductDetailDto?> GetProductByIdAsync(int productId);
    Task<CompatibilityCheckDto?> CheckCompatibilityAsync(int productId, int vehicleId);
    Task<List<ProductDetailDto>> GetProductsByIdsAsync(int[] ids);
    Task<List<ProductSummaryDto>> GetRelatedProductsAsync(int productId, int? vehicleId);
}
