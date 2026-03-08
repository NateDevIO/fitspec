namespace FitSpec.Core.DTOs;

public record ReviewDto(
    string Id,
    int ProductId,
    string ReviewerName,
    int Rating,
    string Title,
    string Body,
    bool VerifiedPurchase,
    DateTime CreatedAt,
    string? VehicleDescription
);

public record ReviewSummaryDto(
    double AverageRating,
    int TotalReviews,
    Dictionary<int, int> RatingDistribution,
    PagedResult<ReviewDto> Reviews
);
