namespace FitSpec.Core.Entities;

public class Order
{
    public int Id { get; set; }
    public int VehicleId { get; set; }
    public DateTime OrderDate { get; set; } = DateTime.UtcNow;
    public decimal TotalAmount { get; set; }

    public Vehicle Vehicle { get; set; } = null!;
    public ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();
}
