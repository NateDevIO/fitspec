using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using FitSpec.ML.Models;
using Microsoft.ML;

namespace FitSpec.ML;

public class RecommendationService : IRecommendationService
{
    private readonly PredictionEngine<ProductCoOccurrence, ProductPrediction>? _predictionEngine;
    private readonly IProductRepository _productRepository;

    public RecommendationService(IProductRepository productRepository, string modelPath = "ml-model.zip")
    {
        _productRepository = productRepository;

        if (File.Exists(modelPath))
        {
            var mlContext = new MLContext();
            var model = mlContext.Model.Load(modelPath, out _);
            _predictionEngine = mlContext.Model.CreatePredictionEngine<ProductCoOccurrence, ProductPrediction>(model);
        }
    }

    public async Task<IEnumerable<ProductRecommendationDto>> GetRecommendationsAsync(int productId, int topN = 4)
    {
        if (_predictionEngine is null)
            return Enumerable.Empty<ProductRecommendationDto>();

        // Score all candidate products (IDs 1-150)
        var candidates = new List<(int ProductId, float Score)>();
        for (int candidateId = 1; candidateId <= 150; candidateId++)
        {
            if (candidateId == productId) continue;

            var prediction = _predictionEngine.Predict(new ProductCoOccurrence
            {
                ProductId1 = (uint)productId,
                ProductId2 = (uint)candidateId
            });

            if (prediction.Score > 0 && !float.IsNaN(prediction.Score))
                candidates.Add((candidateId, prediction.Score));
        }

        var topCandidates = candidates
            .OrderByDescending(c => c.Score)
            .Take(topN)
            .ToList();

        var recommendations = new List<ProductRecommendationDto>();
        foreach (var (candId, score) in topCandidates)
        {
            var product = await _productRepository.GetProductByIdAsync(candId);
            if (product is not null)
            {
                recommendations.Add(new ProductRecommendationDto(
                    product.Id,
                    product.Name,
                    product.Brand,
                    product.Price,
                    product.ImageUrl,
                    product.CategoryName,
                    score
                ));
            }
        }

        return recommendations;
    }
}
