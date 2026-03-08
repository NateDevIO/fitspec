using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Entities;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/products/{productId:int}/qa")]
public class QAController : ControllerBase
{
    private readonly IProductQARepository _qaRepository;

    public QAController(IProductQARepository qaRepository)
    {
        _qaRepository = qaRepository;
    }

    [HttpGet]
    public async Task<ActionResult<ApiResponse<List<ProductQuestionDto>>>> GetQuestions(int productId)
    {
        var questions = await _qaRepository.GetQuestionsAsync(productId);

        var dtos = questions.Select(q => new ProductQuestionDto
        {
            Id = q.Id,
            ProductId = q.ProductId,
            Question = q.Question,
            AskerName = q.AskerName,
            CreatedAt = q.CreatedAt,
            Answers = q.Answers.Select(a => new ProductAnswerDto
            {
                Id = a.Id,
                Answer = a.Answer,
                ResponderName = a.ResponderName,
                CreatedAt = a.CreatedAt
            }).ToList()
        }).ToList();

        return Ok(ApiResponse<List<ProductQuestionDto>>.Ok(dtos));
    }

    [HttpPost]
    public async Task<ActionResult<ApiResponse<ProductQuestionDto>>> AskQuestion(
        int productId,
        [FromBody] AskQuestionRequest request)
    {
        if (string.IsNullOrWhiteSpace(request.Question))
            return BadRequest(ApiResponse<ProductQuestionDto>.Fail("Question is required."));

        if (string.IsNullOrWhiteSpace(request.AskerName))
            return BadRequest(ApiResponse<ProductQuestionDto>.Fail("Asker name is required."));

        var question = new ProductQuestion
        {
            ProductId = productId,
            Question = request.Question,
            AskerName = request.AskerName,
            CreatedAt = DateTime.UtcNow
        };

        var created = await _qaRepository.AddQuestionAsync(question);

        var dto = new ProductQuestionDto
        {
            Id = created.Id,
            ProductId = created.ProductId,
            Question = created.Question,
            AskerName = created.AskerName,
            CreatedAt = created.CreatedAt,
            Answers = new List<ProductAnswerDto>()
        };

        return Ok(ApiResponse<ProductQuestionDto>.Ok(dto));
    }

    [HttpPost("{questionId}/answer")]
    public async Task<ActionResult<ApiResponse<ProductQuestionDto>>> AnswerQuestion(
        int productId,
        string questionId,
        [FromBody] AnswerQuestionRequest request)
    {
        if (string.IsNullOrWhiteSpace(request.Answer))
            return BadRequest(ApiResponse<ProductQuestionDto>.Fail("Answer is required."));

        if (string.IsNullOrWhiteSpace(request.ResponderName))
            return BadRequest(ApiResponse<ProductQuestionDto>.Fail("Responder name is required."));

        var answer = new ProductAnswer
        {
            Id = Guid.NewGuid().ToString(),
            Answer = request.Answer,
            ResponderName = request.ResponderName,
            CreatedAt = DateTime.UtcNow
        };

        await _qaRepository.AddAnswerAsync(questionId, answer);

        // Return the full updated question
        var questions = await _qaRepository.GetQuestionsAsync(productId);
        var updatedQuestion = questions.FirstOrDefault(q => q.Id == questionId);

        if (updatedQuestion is null)
            return NotFound(ApiResponse<ProductQuestionDto>.Fail("Question not found."));

        var dto = new ProductQuestionDto
        {
            Id = updatedQuestion.Id,
            ProductId = updatedQuestion.ProductId,
            Question = updatedQuestion.Question,
            AskerName = updatedQuestion.AskerName,
            CreatedAt = updatedQuestion.CreatedAt,
            Answers = updatedQuestion.Answers.Select(a => new ProductAnswerDto
            {
                Id = a.Id,
                Answer = a.Answer,
                ResponderName = a.ResponderName,
                CreatedAt = a.CreatedAt
            }).ToList()
        };

        return Ok(ApiResponse<ProductQuestionDto>.Ok(dto));
    }
}
