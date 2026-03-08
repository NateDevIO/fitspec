namespace FitSpec.Core.DTOs;

public record ProductSummaryDto(
    int Id,
    string SKU,
    string Name,
    string Brand,
    decimal Price,
    string? ImageUrl,
    string CategoryName,
    int InstallDifficulty,
    bool IsVerified,
    double? AverageRating
);

public record ProductDetailDto
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
    public Dictionary<string, object>? ExtendedSpecs { get; init; }
}

public record ProductFilterParams
{
    public int? CategoryId { get; init; }
    public string? Brand { get; init; }
    public decimal? MinPrice { get; init; }
    public decimal? MaxPrice { get; init; }
    public int? MaxDifficulty { get; init; }
    public bool? VerifiedOnly { get; init; }
    public string Sort { get; init; } = "name";
    public int Page { get; init; } = 1;
    public int PageSize { get; init; } = 12;
}

public record CompatibilityCheckDto(
    bool IsCompatible,
    int? InstallDifficulty,
    string? FitmentNotes,
    bool IsVerified
);

public record ProductRecommendationDto(
    int ProductId,
    string Name,
    string Brand,
    decimal Price,
    string? ImageUrl,
    string CategoryName,
    float Score
);
