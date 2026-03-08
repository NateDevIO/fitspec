using FitSpec.Core.DTOs;

namespace FitSpec.Core.Interfaces;

public interface ISearchRepository
{
    Task<List<SearchResultDto>> SearchAsync(string query, int limit = 10);
}
