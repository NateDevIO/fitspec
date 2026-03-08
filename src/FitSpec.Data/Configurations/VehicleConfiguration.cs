using FitSpec.Core.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitSpec.Data.Configurations;

public class VehicleConfiguration : IEntityTypeConfiguration<Vehicle>
{
    public void Configure(EntityTypeBuilder<Vehicle> builder)
    {
        builder.HasKey(v => v.Id);
        builder.Property(v => v.Trim).HasMaxLength(100);
        builder.Property(v => v.BodyStyle).HasMaxLength(50);
        builder.Property(v => v.DriveType).HasMaxLength(20);
        builder.HasOne(v => v.Make)
            .WithMany()
            .HasForeignKey(v => v.MakeId)
            .OnDelete(DeleteBehavior.Restrict);
        builder.HasOne(v => v.Model)
            .WithMany(m => m.Vehicles)
            .HasForeignKey(v => v.ModelId)
            .OnDelete(DeleteBehavior.Restrict);
        builder.HasIndex(v => new { v.MakeId, v.ModelId });
        builder.HasIndex(v => new { v.MakeId, v.ModelId, v.Year });
    }
}
