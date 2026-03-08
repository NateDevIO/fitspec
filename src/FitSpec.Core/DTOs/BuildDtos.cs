namespace FitSpec.Core.DTOs;

public record BuildExportRequest
{
    public List<BuildExportItem> Items { get; init; } = new();
    public int? VehicleId { get; init; }
    public string? VehicleName { get; init; }
}

public record BuildExportItem(int ProductId, int Quantity);

public record BuildExportProductDto(
    int Id,
    string Name,
    string Brand,
    string SKU,
    decimal Price,
    string CategoryName,
    int? InstallDifficulty,
    string? FitmentNotes
);
