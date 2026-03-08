using FitSpec.Core.DTOs;

namespace FitSpec.Core.Interfaces;

public interface IRecommendationService
{
    Task<IEnumerable<ProductRecommendationDto>> GetRecommendationsAsync(int productId, int topN = 4);
}
