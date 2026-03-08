using FitSpec.Core.DTOs;

namespace FitSpec.Core.Interfaces;

public interface IInventoryRepository
{
    Task<List<InventoryStatusDto>> GetInventoryStatusAsync(int[] productIds);
    Task<InventoryStatusDto?> GetProductInventoryAsync(int productId);
}
