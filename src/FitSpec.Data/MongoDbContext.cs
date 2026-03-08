using FitSpec.Core.Entities;
using Microsoft.Extensions.Configuration;
using MongoDB.Bson;
using MongoDB.Bson.Serialization;
using MongoDB.Bson.Serialization.Conventions;
using MongoDB.Bson.Serialization.IdGenerators;
using MongoDB.Bson.Serialization.Serializers;
using MongoDB.Driver;

namespace FitSpec.Data;

public class MongoDbContext
{
    private readonly IMongoDatabase _database;

    static MongoDbContext()
    {
        var conventionPack = new ConventionPack { new CamelCaseElementNameConvention() };
        ConventionRegistry.Register("camelCase", conventionPack, _ => true);

        BsonClassMap.RegisterClassMap<ProductReview>(cm =>
        {
            cm.AutoMap();
            cm.SetIgnoreExtraElements(true);
            cm.MapIdMember(c => c.Id)
                .SetIdGenerator(StringObjectIdGenerator.Instance)
                .SetSerializer(new StringSerializer(BsonType.ObjectId));
        });

        BsonClassMap.RegisterClassMap<ProductAnswer>(cm =>
        {
            cm.AutoMap();
            cm.SetIgnoreExtraElements(true);
            cm.UnmapMember(c => c.Id);
            cm.MapMember(c => c.Id).SetElementName("id");
        });

        BsonClassMap.RegisterClassMap<ProductQuestion>(cm =>
        {
            cm.AutoMap();
            cm.SetIgnoreExtraElements(true);
            cm.MapIdMember(c => c.Id)
                .SetIdGenerator(StringObjectIdGenerator.Instance)
                .SetSerializer(new StringSerializer(BsonType.ObjectId));
        });
    }

    public MongoDbContext(IConfiguration configuration)
    {
        var connectionString = configuration.GetConnectionString("MongoDb")
            ?? "mongodb://localhost:27017/fitspec";
        var client = new MongoClient(connectionString);
        _database = client.GetDatabase("fitspec");
    }

    public IMongoCollection<ProductReview> Reviews =>
        _database.GetCollection<ProductReview>("reviews");

    public IMongoCollection<ProductCatalogExtended> CatalogExtended =>
        _database.GetCollection<ProductCatalogExtended>("catalog_extended");

    public IMongoCollection<ProductQuestion> Questions =>
        _database.GetCollection<ProductQuestion>("questions");
}
