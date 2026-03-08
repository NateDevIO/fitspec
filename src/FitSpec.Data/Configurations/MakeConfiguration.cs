using FitSpec.Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitSpec.Data.Configurations;

public class MakeConfiguration : IEntityTypeConfiguration<Make>
{
    public void Configure(EntityTypeBuilder<Make> builder)
    {
        builder.HasKey(m => m.Id);
        builder.Property(m => m.Name).HasMaxLength(100).IsRequired();
        builder.Property(m => m.Slug).HasMaxLength(100).IsRequired();
        builder.Property(m => m.LogoUrl).HasMaxLength(500);
        builder.HasIndex(m => m.Slug).IsUnique();
    }
}
