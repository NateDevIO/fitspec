namespace FitSpec.Core.Entities;

public class Product
{
    public int Id { get; set; }
    public string SKU { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string Brand { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public string? ImageUrl { get; set; }
    public int CategoryId { get; set; }
    public bool IsVerified { get; set; }
    public decimal? Weight { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public Category Category { get; set; } = null!;
    public ICollection<FitmentMapping> FitmentMappings { get; set; } = new List<FitmentMapping>();
    public ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();
}
