using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/search")]
public class SearchController : ControllerBase
{
    private readonly ISearchRepository _searchRepository;

    public SearchController(ISearchRepository searchRepository)
    {
        _searchRepository = searchRepository;
    }

    [HttpGet]
    public async Task<ActionResult<ApiResponse<List<SearchResultDto>>>> Search(
        [FromQuery] string q, [FromQuery] int limit = 10)
    {
        if (string.IsNullOrWhiteSpace(q) || q.Length < 2)
            return Ok(ApiResponse<List<SearchResultDto>>.Ok(new List<SearchResultDto>()));

        var results = await _searchRepository.SearchAsync(q, Math.Min(limit, 20));
        return Ok(ApiResponse<List<SearchResultDto>>.Ok(results));
    }
}
