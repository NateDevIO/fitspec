using FitSpec.Core.DTOs;

namespace FitSpec.Core.Interfaces;

public interface IAdminRepository
{
    Task<AdminOverviewDto> GetOverviewAsync();
    Task<List<OrdersByMonthDto>> GetOrdersByMonthAsync(int months = 12);
    Task<List<TopProductDto>> GetTopProductsAsync(int count = 10);
    Task<PagedResult<AdminProductDto>> GetProductsAsync(int page = 1, int pageSize = 20, string? search = null);
    Task<int> CreateProductAsync(ProductCreateDto product);
    Task<bool> UpdateProductAsync(int id, ProductCreateDto product);
    Task<bool> DeleteProductAsync(int id);
}
