namespace FitSpec.Core.Entities;

public class ProductQuestion
{
    public string Id { get; set; } = string.Empty;
    public int ProductId { get; set; }
    public string Question { get; set; } = string.Empty;
    public string AskerName { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public List<ProductAnswer> Answers { get; set; } = new();
}

public class ProductAnswer
{
    public string Id { get; set; } = Guid.NewGuid().ToString();
    public string Answer { get; set; } = string.Empty;
    public string ResponderName { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
