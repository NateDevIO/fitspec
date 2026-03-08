using FitSpec.Core.DTOs;

namespace FitSpec.Core.Interfaces;

public interface ICommunityBuildRepository
{
    Task<List<PopularProductDto>> GetPopularProductsAsync(int vehicleId, int count = 8);
}
