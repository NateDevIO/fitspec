using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/admin")]
public class AdminController : ControllerBase
{
    private readonly IAdminRepository _adminRepository;

    public AdminController(IAdminRepository adminRepository)
    {
        _adminRepository = adminRepository;
    }

    [HttpGet("overview")]
    public async Task<ActionResult<ApiResponse<AdminOverviewDto>>> GetOverview()
    {
        var overview = await _adminRepository.GetOverviewAsync();
        return Ok(ApiResponse<AdminOverviewDto>.Ok(overview));
    }

    [HttpGet("analytics/orders-by-month")]
    public async Task<ActionResult<ApiResponse<List<OrdersByMonthDto>>>> GetOrdersByMonth(
        [FromQuery] int months = 12)
    {
        var data = await _adminRepository.GetOrdersByMonthAsync(months);
        return Ok(ApiResponse<List<OrdersByMonthDto>>.Ok(data));
    }

    [HttpGet("analytics/top-products")]
    public async Task<ActionResult<ApiResponse<List<TopProductDto>>>> GetTopProducts(
        [FromQuery] int count = 10)
    {
        var data = await _adminRepository.GetTopProductsAsync(count);
        return Ok(ApiResponse<List<TopProductDto>>.Ok(data));
    }

    [HttpGet("products")]
    public async Task<ActionResult<ApiResponse<PagedResult<AdminProductDto>>>> GetProducts(
        [FromQuery] int page = 1, [FromQuery] int pageSize = 20, [FromQuery] string? search = null)
    {
        var result = await _adminRepository.GetProductsAsync(page, pageSize, search);
        return Ok(ApiResponse<PagedResult<AdminProductDto>>.Ok(result));
    }

    [HttpPost("products")]
    public async Task<ActionResult<ApiResponse<int>>> CreateProduct([FromBody] ProductCreateDto product)
    {
        var id = await _adminRepository.CreateProductAsync(product);
        return Ok(ApiResponse<int>.Ok(id));
    }

    [HttpPut("products/{id:int}")]
    public async Task<ActionResult<ApiResponse<bool>>> UpdateProduct(int id, [FromBody] ProductCreateDto product)
    {
        var success = await _adminRepository.UpdateProductAsync(id, product);
        if (!success) return NotFound(ApiResponse<bool>.Fail("Product not found."));
        return Ok(ApiResponse<bool>.Ok(true));
    }

    [HttpDelete("products/{id:int}")]
    public async Task<ActionResult<ApiResponse<bool>>> DeleteProduct(int id)
    {
        var success = await _adminRepository.DeleteProductAsync(id);
        if (!success) return NotFound(ApiResponse<bool>.Fail("Product not found."));
        return Ok(ApiResponse<bool>.Ok(true));
    }
}
