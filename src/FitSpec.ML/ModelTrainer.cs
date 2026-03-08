using System.Data;
using Dapper;
using FitSpec.Core.Interfaces;
using FitSpec.ML.Models;
using Microsoft.ML;

namespace FitSpec.ML;

public class ModelTrainer
{
    private readonly IDapperConnectionFactory _connectionFactory;
    private readonly string _modelPath;

    public ModelTrainer(IDapperConnectionFactory connectionFactory, string modelPath = "ml-model.zip")
    {
        _connectionFactory = connectionFactory;
        _modelPath = modelPath;
    }

    public void Train()
    {
        var mlContext = new MLContext(seed: 42);

        // Load co-occurrence data from SQL Server
        var coOccurrences = LoadCoOccurrenceData();
        var dataView = mlContext.Data.LoadFromEnumerable(coOccurrences);

        // Build pipeline
        var pipeline = mlContext.Recommendation().Trainers.MatrixFactorization(
            labelColumnName: nameof(ProductCoOccurrence.CoOccurrenceCount),
            matrixColumnIndexColumnName: nameof(ProductCoOccurrence.ProductId1),
            matrixRowIndexColumnName: nameof(ProductCoOccurrence.ProductId2),
            numberOfIterations: 20,
            approximationRank: 32);

        Console.WriteLine("Training ML.NET recommendation model...");
        var model = pipeline.Fit(dataView);

        // Evaluate
        var predictions = model.Transform(dataView);
        var metrics = mlContext.Regression.Evaluate(predictions,
            labelColumnName: nameof(ProductCoOccurrence.CoOccurrenceCount));
        Console.WriteLine($"RMSE: {metrics.RootMeanSquaredError:F4}");
        Console.WriteLine($"R²: {metrics.RSquared:F4}");

        // Save model
        mlContext.Model.Save(model, dataView.Schema, _modelPath);
        Console.WriteLine($"Model saved to {_modelPath}");
    }

    private List<ProductCoOccurrence> LoadCoOccurrenceData()
    {
        using var connection = _connectionFactory.CreateConnection();
        var data = connection.Query<(int ProductId1, int ProductId2, int CoOccurrenceCount)>(
            "sp_GetProductCoOccurrence",
            new { ProductId = (int?)null, TopN = 100 },
            commandType: CommandType.StoredProcedure);

        return data.Select(d => new ProductCoOccurrence
        {
            ProductId1 = (uint)d.ProductId1,
            ProductId2 = (uint)d.ProductId2,
            CoOccurrenceCount = d.CoOccurrenceCount
        }).ToList();
    }
}
