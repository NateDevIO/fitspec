namespace FitSpec.Core.DTOs;

public record AdminOverviewDto(
    int TotalProducts,
    int TotalOrders,
    decimal TotalRevenue,
    int TotalReviews,
    int TotalVehicles,
    int TotalFitmentMappings
);

public record OrdersByMonthDto(string Month, int OrderCount, decimal Revenue);

public record TopProductDto(int ProductId, string Name, string Brand, int OrderCount, decimal Revenue);

public record AdminProductDto
{
    public int Id { get; init; }
    public string SKU { get; init; } = "";
    public string Name { get; init; } = "";
    public string? Description { get; init; }
    public string Brand { get; init; } = "";
    public decimal Price { get; init; }
    public string? ImageUrl { get; init; }
    public int CategoryId { get; init; }
    public string CategoryName { get; init; } = "";
    public bool IsVerified { get; init; }
    public decimal? Weight { get; init; }
    public DateTime CreatedAt { get; init; }
    public int FitmentCount { get; init; }
}

public record ProductCreateDto
{
    public string SKU { get; init; } = "";
    public string Name { get; init; } = "";
    public string? Description { get; init; }
    public string Brand { get; init; } = "";
    public decimal Price { get; init; }
    public string? ImageUrl { get; init; }
    public int CategoryId { get; init; }
    public bool IsVerified { get; init; }
    public decimal? Weight { get; init; }
}

public record ReviewModerationDto(
    string Id,
    int ProductId,
    string ProductName,
    string ReviewerName,
    int Rating,
    string Title,
    string Body,
    DateTime CreatedAt,
    string Status
);
