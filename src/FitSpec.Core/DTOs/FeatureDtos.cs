namespace FitSpec.Core.DTOs;

public record VinDecodeResultDto(
    string Vin,
    int? Year,
    string? Make,
    string? Model,
    string? Trim,
    string? BodyStyle,
    string? DriveType,
    int? MatchedVehicleId
);

public record ProductQuestionDto
{
    public string Id { get; init; } = "";
    public int ProductId { get; init; }
    public string Question { get; init; } = "";
    public string AskerName { get; init; } = "";
    public DateTime CreatedAt { get; init; }
    public List<ProductAnswerDto> Answers { get; init; } = new();
}

public record ProductAnswerDto
{
    public string Id { get; init; } = "";
    public string Answer { get; init; } = "";
    public string ResponderName { get; init; } = "";
    public DateTime CreatedAt { get; init; }
}

public record AskQuestionRequest(string Question, string AskerName);
public record AnswerQuestionRequest(string Answer, string ResponderName);
public record PriceAlertRequest(string Email);
