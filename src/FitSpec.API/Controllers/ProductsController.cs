using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/products")]
public class ProductsController : ControllerBase
{
    private readonly IProductRepository _productRepository;

    public ProductsController(IProductRepository productRepository)
    {
        _productRepository = productRepository;
    }

    [HttpGet("{productId:int}")]
    public async Task<ActionResult<ApiResponse<ProductDetailDto>>> GetProduct(int productId)
    {
        var product = await _productRepository.GetProductByIdAsync(productId);
        if (product is null)
            return NotFound(ApiResponse<ProductDetailDto>.Fail("Product not found."));
        return Ok(ApiResponse<ProductDetailDto>.Ok(product));
    }

    [HttpGet("{productId:int}/compatibility/{vehicleId:int}")]
    public async Task<ActionResult<ApiResponse<CompatibilityCheckDto>>> CheckCompatibility(int productId, int vehicleId)
    {
        var result = await _productRepository.CheckCompatibilityAsync(productId, vehicleId);
        if (result is null)
            return Ok(ApiResponse<CompatibilityCheckDto>.Ok(new CompatibilityCheckDto(false, null, null, false)));
        return Ok(ApiResponse<CompatibilityCheckDto>.Ok(result));
    }

    [HttpGet("compare")]
    public async Task<ActionResult<ApiResponse<List<ProductDetailDto>>>> CompareProducts(
        [FromQuery] int[] ids)
    {
        if (ids.Length == 0 || ids.Length > 3)
            return BadRequest(ApiResponse<List<ProductDetailDto>>.Fail("Provide 1-3 product IDs."));

        var products = await _productRepository.GetProductsByIdsAsync(ids);
        return Ok(ApiResponse<List<ProductDetailDto>>.Ok(products));
    }

    [HttpGet("{productId:int}/required-accessories")]
    public async Task<ActionResult<ApiResponse<List<ProductSummaryDto>>>> GetRequiredAccessories(
        int productId, [FromQuery] int? vehicleId)
    {
        var accessories = await _productRepository.GetRelatedProductsAsync(productId, vehicleId);
        return Ok(ApiResponse<List<ProductSummaryDto>>.Ok(accessories));
    }
}
