using FitSpec.Core.Entities;
using Microsoft.EntityFrameworkCore;

namespace FitSpec.Data;

public class FitSpecDbContext : DbContext
{
    public FitSpecDbContext(DbContextOptions<FitSpecDbContext> options) : base(options) { }

    public DbSet<Make> Makes => Set<Make>();
    public DbSet<Model> Models => Set<Model>();
    public DbSet<Vehicle> Vehicles => Set<Vehicle>();
    public DbSet<Category> Categories => Set<Category>();
    public DbSet<Product> Products => Set<Product>();
    public DbSet<FitmentMapping> FitmentMappings => Set<FitmentMapping>();
    public DbSet<Order> Orders => Set<Order>();
    public DbSet<OrderItem> OrderItems => Set<OrderItem>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(FitSpecDbContext).Assembly);
    }
}
