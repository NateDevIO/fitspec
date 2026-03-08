using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/products/{productId:int}/reviews")]
public class ReviewsController : ControllerBase
{
    private readonly IProductReviewRepository _reviewRepository;

    public ReviewsController(IProductReviewRepository reviewRepository)
    {
        _reviewRepository = reviewRepository;
    }

    [HttpGet]
    public async Task<ActionResult<ApiResponse<ReviewSummaryDto>>> GetReviews(
        int productId,
        [FromQuery] int? vehicleId,
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 10)
    {
        var summary = await _reviewRepository.GetReviewsAsync(productId, vehicleId, page, pageSize);
        return Ok(ApiResponse<ReviewSummaryDto>.Ok(summary));
    }
}
