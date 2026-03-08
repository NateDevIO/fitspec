namespace FitSpec.Core.Interfaces;

public interface IProductQARepository
{
    Task<List<Core.Entities.ProductQuestion>> GetQuestionsAsync(int productId);
    Task<Core.Entities.ProductQuestion> AddQuestionAsync(Core.Entities.ProductQuestion question);
    Task AddAnswerAsync(string questionId, Core.Entities.ProductAnswer answer);
}
