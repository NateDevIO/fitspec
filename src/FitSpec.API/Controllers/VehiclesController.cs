using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/vehicles")]
public class VehiclesController : ControllerBase
{
    private readonly IVehicleRepository _vehicleRepository;
    private readonly ICategoryRepository _categoryRepository;
    private readonly IProductRepository _productRepository;

    public VehiclesController(
        IVehicleRepository vehicleRepository,
        ICategoryRepository categoryRepository,
        IProductRepository productRepository)
    {
        _vehicleRepository = vehicleRepository;
        _categoryRepository = categoryRepository;
        _productRepository = productRepository;
    }

    [HttpGet("makes")]
    public async Task<ActionResult<ApiResponse<IEnumerable<MakeDto>>>> GetMakes()
    {
        var makes = await _vehicleRepository.GetMakesAsync();
        return Ok(ApiResponse<IEnumerable<MakeDto>>.Ok(makes));
    }

    [HttpGet("makes/{makeId:int}/models")]
    public async Task<ActionResult<ApiResponse<IEnumerable<ModelDto>>>> GetModels(int makeId)
    {
        var models = await _vehicleRepository.GetModelsByMakeAsync(makeId);
        return Ok(ApiResponse<IEnumerable<ModelDto>>.Ok(models));
    }

    [HttpGet("makes/{makeId:int}/models/{modelId:int}/years")]
    public async Task<ActionResult<ApiResponse<IEnumerable<VehicleYearDto>>>> GetYears(int makeId, int modelId)
    {
        var years = await _vehicleRepository.GetYearsByMakeAndModelAsync(makeId, modelId);
        return Ok(ApiResponse<IEnumerable<VehicleYearDto>>.Ok(years));
    }

    [HttpGet("{vehicleId:int}")]
    public async Task<ActionResult<ApiResponse<VehicleDetailDto>>> GetVehicle(int vehicleId)
    {
        var vehicle = await _vehicleRepository.GetVehicleByIdAsync(vehicleId);
        if (vehicle is null)
            return NotFound(ApiResponse<VehicleDetailDto>.Fail("Vehicle not found."));
        return Ok(ApiResponse<VehicleDetailDto>.Ok(vehicle));
    }

    [HttpGet("{vehicleId:int}/categories")]
    public async Task<ActionResult<ApiResponse<IEnumerable<CategoryBreakdownDto>>>> GetCategoryBreakdown(int vehicleId)
    {
        var breakdown = await _categoryRepository.GetCategoryBreakdownAsync(vehicleId);
        return Ok(ApiResponse<IEnumerable<CategoryBreakdownDto>>.Ok(breakdown));
    }

    [HttpGet("{vehicleId:int}/products")]
    public async Task<ActionResult<ApiResponse<PagedResult<ProductSummaryDto>>>> GetProducts(
        int vehicleId,
        [FromQuery] ProductFilterParams filters)
    {
        var result = await _productRepository.GetCompatibleProductsAsync(vehicleId, filters);
        var meta = new ApiMeta
        {
            Page = result.Page,
            PageSize = result.PageSize,
            TotalCount = result.TotalCount,
            TotalPages = result.TotalPages
        };
        return Ok(ApiResponse<PagedResult<ProductSummaryDto>>.Ok(result, meta));
    }
}
