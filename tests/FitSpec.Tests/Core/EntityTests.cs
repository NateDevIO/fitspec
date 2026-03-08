using FluentAssertions;
using FitSpec.Core.Entities;

namespace FitSpec.Tests.Core;

public class EntityTests
{
    [Fact]
    public void Vehicle_ShouldInitializeCollections()
    {
        var vehicle = new Vehicle();
        vehicle.FitmentMappings.Should().NotBeNull();
        vehicle.FitmentMappings.Should().BeEmpty();
    }

    [Fact]
    public void Category_ShouldSupportSelfReferencingHierarchy()
    {
        var parent = new Category { Id = 1, Name = "Towing", Slug = "towing" };
        var child = new Category { Id = 5, Name = "Hitches", Slug = "hitches", ParentCategoryId = 1, ParentCategory = parent };
        parent.Children.Add(child);

        parent.Children.Should().HaveCount(1);
        child.ParentCategory.Should().Be(parent);
    }

    [Fact]
    public void Product_ShouldInitializeWithDefaults()
    {
        var product = new Product();
        product.FitmentMappings.Should().NotBeNull();
        product.OrderItems.Should().NotBeNull();
        product.CreatedAt.Should().BeCloseTo(DateTime.UtcNow, TimeSpan.FromSeconds(5));
    }

    [Fact]
    public void FitmentMapping_DifficultyRange()
    {
        var mapping = new FitmentMapping { InstallDifficulty = 3 };
        mapping.InstallDifficulty.Should().BeInRange(1, 5);
    }
}
