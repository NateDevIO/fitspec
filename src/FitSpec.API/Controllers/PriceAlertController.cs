using Asp.Versioning;
using FitSpec.Core.DTOs;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Concurrent;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/products/{productId:int}/price-alerts")]
public class PriceAlertController : ControllerBase
{
    private static readonly ConcurrentDictionary<int, List<string>> _alerts = new();

    [HttpPost]
    public ActionResult<ApiResponse<string>> Subscribe(
        int productId,
        [FromBody] PriceAlertRequest request)
    {
        if (string.IsNullOrWhiteSpace(request.Email))
            return BadRequest(ApiResponse<string>.Fail("Email is required."));

        var emails = _alerts.GetOrAdd(productId, _ => new List<string>());

        lock (emails)
        {
            if (!emails.Contains(request.Email, StringComparer.OrdinalIgnoreCase))
            {
                emails.Add(request.Email);
            }
        }

        return Ok(ApiResponse<string>.Ok(
            $"Price alert registered for product {productId}. We'll notify {request.Email} when the price changes."));
    }
}
