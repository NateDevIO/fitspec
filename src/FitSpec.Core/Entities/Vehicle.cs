namespace FitSpec.Core.Entities;

public class Vehicle
{
    public int Id { get; set; }
    public int Year { get; set; }
    public int MakeId { get; set; }
    public int ModelId { get; set; }
    public string? Trim { get; set; }
    public string? BodyStyle { get; set; }
    public string? DriveType { get; set; }
    public int? TowCapacityLbs { get; set; }

    public Make Make { get; set; } = null!;
    public Model Model { get; set; } = null!;
    public ICollection<FitmentMapping> FitmentMappings { get; set; } = new List<FitmentMapping>();
}
