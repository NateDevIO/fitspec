using FitSpec.Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitSpec.Data.Configurations;

public class FitmentMappingConfiguration : IEntityTypeConfiguration<FitmentMapping>
{
    public void Configure(EntityTypeBuilder<FitmentMapping> builder)
    {
        builder.HasKey(f => f.Id);
        builder.Property(f => f.FitmentNotes).HasMaxLength(500);
        builder.HasOne(f => f.Product)
            .WithMany(p => p.FitmentMappings)
            .HasForeignKey(f => f.ProductId)
            .OnDelete(DeleteBehavior.Cascade);
        builder.HasOne(f => f.Vehicle)
            .WithMany(v => v.FitmentMappings)
            .HasForeignKey(f => f.VehicleId)
            .OnDelete(DeleteBehavior.Cascade);
        builder.HasIndex(f => f.VehicleId);
        builder.HasIndex(f => new { f.ProductId, f.VehicleId }).IsUnique();
    }
}
