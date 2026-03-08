namespace FitSpec.Core.DTOs;

public record ApiResponse<T>
{
    public bool Success { get; init; } = true;
    public T? Data { get; init; }
    public ApiMeta? Meta { get; init; }
    public List<string>? Errors { get; init; }

    public static ApiResponse<T> Ok(T data, ApiMeta? meta = null) =>
        new() { Data = data, Meta = meta };

    public static ApiResponse<T> Fail(params string[] errors) =>
        new() { Success = false, Errors = errors.ToList() };
}

public record ApiMeta
{
    public int? Page { get; init; }
    public int? PageSize { get; init; }
    public int? TotalCount { get; init; }
    public int? TotalPages { get; init; }
}

public record PagedResult<T>
{
    public List<T> Items { get; init; } = new();
    public int TotalCount { get; init; }
    public int Page { get; init; }
    public int PageSize { get; init; }
    public int TotalPages => (int)Math.Ceiling((double)TotalCount / PageSize);
}
