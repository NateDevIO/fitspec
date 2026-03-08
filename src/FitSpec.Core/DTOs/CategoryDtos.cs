namespace FitSpec.Core.DTOs;

public record CategoryDto(
    int Id,
    string Name,
    string Slug,
    string? Icon,
    int? ParentCategoryId,
    List<CategoryDto> Children
);

public record CategoryBreakdownDto(
    int CategoryId,
    string Name,
    string Slug,
    string? Icon,
    int ProductCount
);
