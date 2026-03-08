using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/vehicles/{vehicleId:int}/community")]
public class CommunityBuildsController : ControllerBase
{
    private readonly ICommunityBuildRepository _communityBuildRepository;

    public CommunityBuildsController(ICommunityBuildRepository communityBuildRepository)
    {
        _communityBuildRepository = communityBuildRepository;
    }

    [HttpGet("popular-products")]
    public async Task<ActionResult<ApiResponse<List<PopularProductDto>>>> GetPopularProducts(
        int vehicleId, [FromQuery] int count = 8)
    {
        var products = await _communityBuildRepository.GetPopularProductsAsync(vehicleId, count);
        return Ok(ApiResponse<List<PopularProductDto>>.Ok(products));
    }
}
