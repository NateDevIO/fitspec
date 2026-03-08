using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/products/{productId:int}/recommendations")]
public class RecommendationsController : ControllerBase
{
    private readonly IRecommendationService _recommendationService;

    public RecommendationsController(IRecommendationService recommendationService)
    {
        _recommendationService = recommendationService;
    }

    [HttpGet]
    public async Task<ActionResult<ApiResponse<IEnumerable<ProductRecommendationDto>>>> GetRecommendations(
        int productId,
        [FromQuery] int topN = 4)
    {
        var recommendations = await _recommendationService.GetRecommendationsAsync(productId, topN);
        return Ok(ApiResponse<IEnumerable<ProductRecommendationDto>>.Ok(recommendations));
    }
}
