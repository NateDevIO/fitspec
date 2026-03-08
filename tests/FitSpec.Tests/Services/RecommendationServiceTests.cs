using FluentAssertions;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using NSubstitute;

namespace FitSpec.Tests.Services;

public class RecommendationServiceTests
{
    [Fact]
    public async Task GetRecommendations_NoModelFile_ShouldReturnEmpty()
    {
        var productRepo = Substitute.For<IProductRepository>();
        var service = new FitSpec.ML.RecommendationService(productRepo, "nonexistent-model.zip");

        var results = await service.GetRecommendationsAsync(1, 4);

        results.Should().BeEmpty();
    }
}
