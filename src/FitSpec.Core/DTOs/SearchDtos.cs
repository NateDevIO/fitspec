namespace FitSpec.Core.DTOs;

public record SearchResultDto(
    string Type,      // "product", "brand", "category"
    int Id,
    string Title,
    string? Subtitle,
    string? ImageUrl,
    decimal? Price
);
