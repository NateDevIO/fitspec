using FitSpec.Core.DTOs;

namespace FitSpec.Core.Interfaces;

public interface IProductReviewRepository
{
    Task<ReviewSummaryDto> GetReviewsAsync(int productId, int? vehicleId, int page = 1, int pageSize = 10);
}
