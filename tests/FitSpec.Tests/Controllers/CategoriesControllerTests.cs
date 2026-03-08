using FluentAssertions;
using FitSpec.API.Controllers;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using NSubstitute;

namespace FitSpec.Tests.Controllers;

public class CategoriesControllerTests
{
    private readonly ICategoryRepository _categoryRepo = Substitute.For<ICategoryRepository>();
    private readonly CategoriesController _controller;

    public CategoriesControllerTests()
    {
        _controller = new CategoriesController(_categoryRepo);
    }

    [Fact]
    public async Task GetCategories_ShouldReturnCategoryTree()
    {
        var tree = new List<CategoryDto>
        {
            new(1, "Towing", "towing", "local_shipping", null, new List<CategoryDto>
            {
                new(5, "Trailer Hitches", "trailer-hitches", "tow", 1, new List<CategoryDto>())
            })
        };
        _categoryRepo.GetCategoryTreeAsync().Returns(tree);

        var result = await _controller.GetCategories();

        var ok = result.Result.Should().BeOfType<OkObjectResult>().Subject;
        var response = ok.Value.Should().BeOfType<ApiResponse<IEnumerable<CategoryDto>>>().Subject;
        response.Data.Should().HaveCount(1);
        response.Data!.First().Children.Should().HaveCount(1);
    }
}
