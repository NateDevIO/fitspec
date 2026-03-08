using Microsoft.ML.Data;

namespace FitSpec.ML.Models;

public class ProductCoOccurrence
{
    [KeyType(count: 200)]
    public uint ProductId1 { get; set; }

    [KeyType(count: 200)]
    public uint ProductId2 { get; set; }

    public float CoOccurrenceCount { get; set; }
}

public class ProductPrediction
{
    public float Score { get; set; }
}
