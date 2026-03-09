using FluentAssertions;
using FitSpec.API.Controllers;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using NSubstitute;

namespace FitSpec.Tests.Controllers;

public class ProductsControllerTests
{
    private readonly IProductRepository _productRepo = Substitute.For<IProductRepository>();
    private readonly ProductsController _controller;

    public ProductsControllerTests()
    {
        _controller = new ProductsController(_productRepo);
    }

    [Fact]
    public async Task GetProduct_Found_ShouldReturnOk()
    {
        var product = new ProductDetailDto
        {
            Id = 1, SKU = "TOW-CURT-001", Name = "CURT Class III Hitch",
            Description = "Fits most trucks", Brand = "CURT", Price = 249.99m,
            ImageUrl = null, CategoryId = 5, CategoryName = "Trailer Hitches",
            IsVerified = true, Weight = 45.5m, CreatedAt = DateTime.UtcNow,
            ExtendedSpecs = null
        };
        _productRepo.GetProductByIdAsync(1).Returns(product);

        var result = await _controller.GetProduct(1);

        var ok = result.Result.Should().BeOfType<OkObjectResult>().Subject;
        var response = ok.Value.Should().BeOfType<ApiResponse<ProductDetailDto>>().Subject;
        response.Data!.Name.Should().Be("CURT Class III Hitch");
    }

    [Fact]
    public async Task GetProduct_NotFound_ShouldReturn404()
    {
        _productRepo.GetProductByIdAsync(999).Returns((ProductDetailDto?)null);

        var result = await _controller.GetProduct(999);

        result.Result.Should().BeOfType<NotFoundObjectResult>();
    }

    [Fact]
    public async Task CheckCompatibility_Compatible_ShouldReturnTrue()
    {
        var compat = new CompatibilityCheckDto(true, 2, "Direct bolt-on", true);
        _productRepo.CheckCompatibilityAsync(1, 1).Returns(compat);

        var result = await _controller.CheckCompatibility(1, 1);

        var ok = result.Result.Should().BeOfType<OkObjectResult>().Subject;
        var response = ok.Value.Should().BeOfType<ApiResponse<CompatibilityCheckDto>>().Subject;
        response.Data!.IsCompatible.Should().BeTrue();
        response.Data.InstallDifficulty.Should().Be(2);
    }

    [Fact]
    public async Task CheckCompatibility_NotCompatible_ShouldReturnFalse()
    {
        _productRepo.CheckCompatibilityAsync(1, 999).Returns((CompatibilityCheckDto?)null);

        var result = await _controller.CheckCompatibility(1, 999);

        var ok = result.Result.Should().BeOfType<OkObjectResult>().Subject;
        var response = ok.Value.Should().BeOfType<ApiResponse<CompatibilityCheckDto>>().Subject;
        response.Data!.IsCompatible.Should().BeFalse();
    }
}
