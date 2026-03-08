using FluentAssertions;
using FitSpec.API.Controllers;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using NSubstitute;

namespace FitSpec.Tests.Controllers;

public class VehiclesControllerTests
{
    private readonly IVehicleRepository _vehicleRepo = Substitute.For<IVehicleRepository>();
    private readonly ICategoryRepository _categoryRepo = Substitute.For<ICategoryRepository>();
    private readonly IProductRepository _productRepo = Substitute.For<IProductRepository>();
    private readonly VehiclesController _controller;

    public VehiclesControllerTests()
    {
        _controller = new VehiclesController(_vehicleRepo, _categoryRepo, _productRepo);
    }

    [Fact]
    public async Task GetMakes_ShouldReturnOkWithMakes()
    {
        var makes = new List<MakeDto>
        {
            new(1, "Ford", "ford", null),
            new(2, "Toyota", "toyota", null)
        };
        _vehicleRepo.GetMakesAsync().Returns(makes);

        var result = await _controller.GetMakes();

        var ok = result.Result.Should().BeOfType<OkObjectResult>().Subject;
        var response = ok.Value.Should().BeOfType<ApiResponse<IEnumerable<MakeDto>>>().Subject;
        response.Success.Should().BeTrue();
        response.Data.Should().HaveCount(2);
    }

    [Fact]
    public async Task GetModels_ShouldReturnModelsForMake()
    {
        var models = new List<ModelDto> { new(1, "F-150", "f-150") };
        _vehicleRepo.GetModelsByMakeAsync(1).Returns(models);

        var result = await _controller.GetModels(1);

        var ok = result.Result.Should().BeOfType<OkObjectResult>().Subject;
        var response = ok.Value.Should().BeOfType<ApiResponse<IEnumerable<ModelDto>>>().Subject;
        response.Data.Should().HaveCount(1);
    }

    [Fact]
    public async Task GetVehicle_NotFound_ShouldReturn404()
    {
        _vehicleRepo.GetVehicleByIdAsync(999).Returns((VehicleDetailDto?)null);

        var result = await _controller.GetVehicle(999);

        result.Result.Should().BeOfType<NotFoundObjectResult>();
    }

    [Fact]
    public async Task GetVehicle_Found_ShouldReturnOk()
    {
        var vehicle = new VehicleDetailDto(1, 2023, "Ford", "F-150", "XLT", "Crew Cab", "4WD", 13300);
        _vehicleRepo.GetVehicleByIdAsync(1).Returns(vehicle);

        var result = await _controller.GetVehicle(1);

        var ok = result.Result.Should().BeOfType<OkObjectResult>().Subject;
        var response = ok.Value.Should().BeOfType<ApiResponse<VehicleDetailDto>>().Subject;
        response.Data!.Make.Should().Be("Ford");
        response.Data.Year.Should().Be(2023);
    }

    [Fact]
    public async Task GetYears_ShouldReturnYearsForMakeAndModel()
    {
        var years = new List<VehicleYearDto>
        {
            new(1, 2023, "XLT", "Crew Cab"),
            new(2, 2024, "Lariat", "Crew Cab")
        };
        _vehicleRepo.GetYearsByMakeAndModelAsync(1, 1).Returns(years);

        var result = await _controller.GetYears(1, 1);

        var ok = result.Result.Should().BeOfType<OkObjectResult>().Subject;
        var response = ok.Value.Should().BeOfType<ApiResponse<IEnumerable<VehicleYearDto>>>().Subject;
        response.Data.Should().HaveCount(2);
    }

    [Fact]
    public async Task GetCategoryBreakdown_ShouldReturnCategories()
    {
        var breakdown = new List<CategoryBreakdownDto>
        {
            new(5, "Trailer Hitches", "trailer-hitches", "tow", 12),
            new(9, "Running Boards", "running-boards", "stairs", 8)
        };
        _categoryRepo.GetCategoryBreakdownAsync(1).Returns(breakdown);

        var result = await _controller.GetCategoryBreakdown(1);

        var ok = result.Result.Should().BeOfType<OkObjectResult>().Subject;
        var response = ok.Value.Should().BeOfType<ApiResponse<IEnumerable<CategoryBreakdownDto>>>().Subject;
        response.Data.Should().HaveCount(2);
    }
}
