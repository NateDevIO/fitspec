using FitSpec.Core.DTOs;
using FitSpec.Core.Entities;
using FitSpec.Core.Interfaces;
using MongoDB.Driver;

namespace FitSpec.Data.Repositories;

public class ProductReviewRepository : IProductReviewRepository
{
    private readonly MongoDbContext _context;

    public ProductReviewRepository(MongoDbContext context)
    {
        _context = context;
    }

    public async Task<ReviewSummaryDto> GetReviewsAsync(int productId, int? vehicleId, int page = 1, int pageSize = 10)
    {
        var filterBuilder = Builders<ProductReview>.Filter;
        var filter = filterBuilder.Eq(r => r.ProductId, productId);

        if (vehicleId.HasValue)
            filter &= filterBuilder.Eq(r => r.VehicleId, vehicleId.Value);

        var totalCount = await _context.Reviews.CountDocumentsAsync(filter);

        var reviews = await _context.Reviews
            .Find(filter)
            .SortByDescending(r => r.CreatedAt)
            .Skip((page - 1) * pageSize)
            .Limit(pageSize)
            .ToListAsync();

        // Calculate rating distribution
        var allReviewsFilter = filterBuilder.Eq(r => r.ProductId, productId);
        var allReviews = await _context.Reviews
            .Find(allReviewsFilter)
            .Project(r => r.Rating)
            .ToListAsync();

        var distribution = new Dictionary<int, int>
        {
            { 1, 0 }, { 2, 0 }, { 3, 0 }, { 4, 0 }, { 5, 0 }
        };
        foreach (var rating in allReviews)
        {
            if (distribution.ContainsKey(rating))
                distribution[rating]++;
        }

        var avgRating = allReviews.Count > 0 ? allReviews.Average() : 0;

        var reviewDtos = reviews.Select(r => new ReviewDto(
            r.Id, r.ProductId, r.ReviewerName, r.Rating, r.Title,
            r.Body, r.VerifiedPurchase, r.CreatedAt, r.VehicleDescription
        )).ToList();

        return new ReviewSummaryDto(
            Math.Round(avgRating, 1),
            (int)totalCount,
            distribution,
            new PagedResult<ReviewDto>
            {
                Items = reviewDtos,
                TotalCount = allReviews.Count,
                Page = page,
                PageSize = pageSize
            }
        );
    }
}
