namespace FitSpec.Core.Entities;

public class Make
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string? LogoUrl { get; set; }

    public ICollection<Model> Models { get; set; } = new List<Model>();
}
