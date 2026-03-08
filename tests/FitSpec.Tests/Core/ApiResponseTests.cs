using FluentAssertions;
using FitSpec.Core.DTOs;

namespace FitSpec.Tests.Core;

public class ApiResponseTests
{
    [Fact]
    public void Ok_ShouldCreateSuccessResponse()
    {
        var data = new MakeDto(1, "Ford", "ford", null);
        var response = ApiResponse<MakeDto>.Ok(data);

        response.Success.Should().BeTrue();
        response.Data.Should().Be(data);
        response.Errors.Should().BeNull();
    }

    [Fact]
    public void Ok_WithMeta_ShouldIncludeMetadata()
    {
        var meta = new ApiMeta { Page = 1, PageSize = 10, TotalCount = 100, TotalPages = 10 };
        var response = ApiResponse<string>.Ok("test", meta);

        response.Success.Should().BeTrue();
        response.Meta.Should().Be(meta);
    }

    [Fact]
    public void Fail_ShouldCreateErrorResponse()
    {
        var response = ApiResponse<string>.Fail("Error1", "Error2");

        response.Success.Should().BeFalse();
        response.Errors.Should().HaveCount(2);
        response.Errors.Should().Contain("Error1");
        response.Data.Should().BeNull();
    }

    [Fact]
    public void PagedResult_TotalPages_ShouldCalculateCorrectly()
    {
        var result = new PagedResult<int>
        {
            Items = new List<int> { 1, 2, 3 },
            TotalCount = 25,
            Page = 1,
            PageSize = 10
        };

        result.TotalPages.Should().Be(3);
    }

    [Fact]
    public void PagedResult_TotalPages_ExactDivision()
    {
        var result = new PagedResult<int>
        {
            TotalCount = 20,
            PageSize = 10,
            Page = 1
        };

        result.TotalPages.Should().Be(2);
    }
}
