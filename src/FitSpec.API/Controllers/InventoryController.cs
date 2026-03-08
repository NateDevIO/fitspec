using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/inventory")]
public class InventoryController : ControllerBase
{
    private readonly IInventoryRepository _inventoryRepository;

    public InventoryController(IInventoryRepository inventoryRepository)
    {
        _inventoryRepository = inventoryRepository;
    }

    [HttpGet]
    public async Task<ActionResult<ApiResponse<List<InventoryStatusDto>>>> GetInventoryStatus(
        [FromQuery] int[] productIds)
    {
        if (productIds.Length == 0)
            return Ok(ApiResponse<List<InventoryStatusDto>>.Ok(new List<InventoryStatusDto>()));

        var statuses = await _inventoryRepository.GetInventoryStatusAsync(productIds);
        return Ok(ApiResponse<List<InventoryStatusDto>>.Ok(statuses));
    }

    [HttpGet("{productId:int}")]
    public async Task<ActionResult<ApiResponse<InventoryStatusDto>>> GetProductInventory(int productId)
    {
        var status = await _inventoryRepository.GetProductInventoryAsync(productId);
        if (status is null)
            return NotFound(ApiResponse<InventoryStatusDto>.Fail("Product not found."));
        return Ok(ApiResponse<InventoryStatusDto>.Ok(status));
    }
}
