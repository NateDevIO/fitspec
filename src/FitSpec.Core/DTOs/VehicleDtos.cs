namespace FitSpec.Core.DTOs;

public record MakeDto(int Id, string Name, string Slug, string? LogoUrl);

public record ModelDto(int Id, string Name, string Slug);

public record VehicleYearDto(int VehicleId, int Year, string? Trim, string? BodyStyle);

public record VehicleDetailDto(
    int Id,
    int Year,
    string Make,
    string Model,
    string? Trim,
    string? BodyStyle,
    string? DriveType,
    int? TowCapacityLbs
);
