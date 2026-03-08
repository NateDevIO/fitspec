namespace FitSpec.Core.DTOs;

public record CommunityBuildDto
{
    public List<CommunityBuildProductDto> Products { get; init; } = new();
    public decimal TotalPrice { get; init; }
    public int BuildCount { get; init; }
}

public record CommunityBuildProductDto(
    int Id,
    string Name,
    string Brand,
    decimal Price,
    string? ImageUrl,
    string CategoryName
);

public record PopularProductDto(
    int ProductId,
    string Name,
    string Brand,
    decimal Price,
    string? ImageUrl,
    string CategoryName,
    int InstallCount
);
