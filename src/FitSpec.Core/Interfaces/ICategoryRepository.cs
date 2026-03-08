using FitSpec.Core.DTOs;

namespace FitSpec.Core.Interfaces;

public interface ICategoryRepository
{
    Task<IEnumerable<CategoryDto>> GetCategoryTreeAsync();
    Task<IEnumerable<CategoryBreakdownDto>> GetCategoryBreakdownAsync(int vehicleId);
}
