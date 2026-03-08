namespace FitSpec.Core.Entities;

public class ProductReview
{
    public string Id { get; set; } = string.Empty;
    public int ProductId { get; set; }
    public int? VehicleId { get; set; }
    public string ReviewerName { get; set; } = string.Empty;
    public int Rating { get; set; } // 1-5
    public string Title { get; set; } = string.Empty;
    public string Body { get; set; } = string.Empty;
    public bool VerifiedPurchase { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public string? VehicleDescription { get; set; }
}
