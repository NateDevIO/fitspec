namespace FitSpec.Core.DTOs;

public record InventoryStatusDto(
    int ProductId,
    int StockQuantity,
    string Status  // "in_stock", "low_stock", "out_of_stock"
);

public record PriceUpdateDto(int ProductId, decimal OldPrice, decimal NewPrice);
