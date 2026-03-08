namespace FitSpec.Core.Entities;

public class ProductCatalogExtended
{
    public string Id { get; set; } = string.Empty;
    public int ProductId { get; set; }
    public Dictionary<string, object> Specs { get; set; } = new();
    public List<string> Features { get; set; } = new();
    public string? InstallGuideUrl { get; set; }
    public List<string> CompatibilityNotes { get; set; } = new();
}
