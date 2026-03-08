namespace FitSpec.Core.DTOs;

public record ChatRequest
{
    public string Message { get; init; } = "";
    public int? VehicleId { get; init; }
    public int? ProductId { get; init; }
    public List<ChatMessage> History { get; init; } = new();
}

public record ChatMessage(string Role, string Content);

public record ChatResponse(string Message, string? SuggestedProductId = null);
