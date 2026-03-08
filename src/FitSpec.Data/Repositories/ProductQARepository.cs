using FitSpec.Core.Entities;
using FitSpec.Core.Interfaces;
using MongoDB.Driver;

namespace FitSpec.Data.Repositories;

public class ProductQARepository : IProductQARepository
{
    private readonly MongoDbContext _context;

    public ProductQARepository(MongoDbContext context)
    {
        _context = context;
    }

    public async Task<List<ProductQuestion>> GetQuestionsAsync(int productId)
    {
        var filter = Builders<ProductQuestion>.Filter.Eq(q => q.ProductId, productId);
        return await _context.Questions
            .Find(filter)
            .SortByDescending(q => q.CreatedAt)
            .ToListAsync();
    }

    public async Task<ProductQuestion> AddQuestionAsync(ProductQuestion question)
    {
        await _context.Questions.InsertOneAsync(question);
        return question;
    }

    public async Task AddAnswerAsync(string questionId, ProductAnswer answer)
    {
        var filter = Builders<ProductQuestion>.Filter.Eq(q => q.Id, questionId);
        var update = Builders<ProductQuestion>.Update.Push(q => q.Answers, answer);
        await _context.Questions.UpdateOneAsync(filter, update);
    }
}
