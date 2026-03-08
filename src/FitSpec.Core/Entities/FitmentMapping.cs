namespace FitSpec.Core.Entities;

public class FitmentMapping
{
    public int Id { get; set; }
    public int ProductId { get; set; }
    public int VehicleId { get; set; }
    public int InstallDifficulty { get; set; } // 1-5
    public string? FitmentNotes { get; set; }
    public bool IsVerified { get; set; }

    public Product Product { get; set; } = null!;
    public Vehicle Vehicle { get; set; } = null!;
}
