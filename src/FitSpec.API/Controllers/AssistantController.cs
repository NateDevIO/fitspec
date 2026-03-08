using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/assistant")]
public class AssistantController : ControllerBase
{
    private readonly IProductRepository _productRepository;
    private readonly IVehicleRepository _vehicleRepository;
    private readonly ISearchRepository _searchRepository;
    private readonly IConfiguration _configuration;
    private readonly IHttpClientFactory _httpClientFactory;

    public AssistantController(
        IProductRepository productRepository,
        IVehicleRepository vehicleRepository,
        ISearchRepository searchRepository,
        IConfiguration configuration,
        IHttpClientFactory httpClientFactory)
    {
        _productRepository = productRepository;
        _vehicleRepository = vehicleRepository;
        _searchRepository = searchRepository;
        _configuration = configuration;
        _httpClientFactory = httpClientFactory;
    }

    [HttpPost("chat")]
    public async Task<ActionResult<ApiResponse<ChatResponse>>> Chat([FromBody] ChatRequest request)
    {
        var apiKey = _configuration["Claude:ApiKey"];
        if (string.IsNullOrEmpty(apiKey))
            return Ok(ApiResponse<ChatResponse>.Ok(new ChatResponse(
                "The AI assistant is not configured. Please set the Claude API key in appsettings.json.")));

        // Build context from vehicle/product if provided
        var contextParts = new List<string>();
        string? vehicleName = null;

        // If user has a vehicle selected, fetch vehicle details and compatible products
        if (request.VehicleId.HasValue)
        {
            var vehicle = await _vehicleRepository.GetVehicleByIdAsync(request.VehicleId.Value);
            if (vehicle != null)
            {
                vehicleName = $"{vehicle.Year} {vehicle.Make} {vehicle.Model}";
                var vehicleInfo = $"The user's vehicle is a {vehicleName}";
                if (!string.IsNullOrEmpty(vehicle.Trim)) vehicleInfo += $" {vehicle.Trim}";
                if (!string.IsNullOrEmpty(vehicle.BodyStyle)) vehicleInfo += $" ({vehicle.BodyStyle})";
                if (!string.IsNullOrEmpty(vehicle.DriveType)) vehicleInfo += $", {vehicle.DriveType}";
                if (vehicle.TowCapacityLbs.HasValue) vehicleInfo += $", Tow Capacity: {vehicle.TowCapacityLbs:N0} lbs";
                vehicleInfo += ".";
                contextParts.Add(vehicleInfo);
            }

            var filters = new ProductFilterParams { Page = 1, PageSize = 50 };
            var compatibleProducts = await _productRepository.GetCompatibleProductsAsync(request.VehicleId.Value, filters);
            if (compatibleProducts.Items.Any())
            {
                var productList = string.Join("\n", compatibleProducts.Items.Select(p =>
                    $"- {p.Brand} {p.Name} | SKU: {p.SKU} | ${p.Price} | Category: {p.CategoryName} | Install Difficulty: {p.InstallDifficulty}/5 | Fitment Verified: {(p.IsVerified ? "YES" : "No")}"));
                contextParts.Add($"CONFIRMED COMPATIBLE PRODUCTS for this vehicle (these are verified fits — you can confidently tell the user these fit their vehicle):\n{productList}");
            }
        }

        // If user is viewing a specific product, include its details
        if (request.ProductId.HasValue)
        {
            var product = await _productRepository.GetProductByIdAsync(request.ProductId.Value);
            if (product != null)
            {
                contextParts.Add($"The user is currently viewing: {product.Brand} {product.Name} | SKU: {product.SKU} | ${product.Price} | Category: {product.CategoryName} | Description: {product.Description}.");
            }
        }

        // Extract keywords from user's message and search for relevant products
        var stopWords = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
        {
            "what", "which", "where", "when", "how", "who", "why", "is", "are", "do", "does",
            "can", "could", "would", "should", "the", "a", "an", "and", "or", "but", "in",
            "on", "at", "to", "for", "of", "with", "by", "from", "as", "that", "this",
            "it", "its", "my", "your", "our", "you", "i", "we", "they", "some", "any",
            "have", "has", "had", "be", "been", "being", "will", "about", "carry", "sell",
            "get", "best", "good", "top", "most", "popular", "brands", "brand", "types"
        };
        var keywords = request.Message
            .Split(new[] { ' ', '?', '!', '.', ',', '\'', '"' }, StringSplitOptions.RemoveEmptyEntries)
            .Where(w => w.Length > 2 && !stopWords.Contains(w))
            .Take(4)
            .ToList();

        var allSearchResults = new List<SearchResultDto>();
        foreach (var keyword in keywords)
        {
            var results = await _searchRepository.SearchAsync(keyword, 8);
            allSearchResults.AddRange(results);
        }
        var uniqueResults = allSearchResults
            .GroupBy(r => r.Id)
            .Select(g => g.First())
            .Take(15)
            .ToList();

        if (uniqueResults.Any())
        {
            var searchList = string.Join("\n", uniqueResults.Select(r =>
                $"- {r.Title} by {r.Subtitle} (${r.Price})"));
            contextParts.Add($"Products matching the user's question:\n{searchList}");
        }

        var systemPrompt = $"""
            You are FitSpec's AI Fitment Assistant. You help customers find the right vehicle parts and accessories.
            You have DIRECT ACCESS to our real product catalog and fitment database (provided below).

            IMPORTANT RULES:
            - Products listed under "CONFIRMED COMPATIBLE PRODUCTS" are verified fits for the user's specific vehicle. You CAN and SHOULD confidently confirm these fit.
            - Include SKU numbers when referencing products so customers can find them easily.
            - Reference specific products, brands, prices, and installation difficulty ratings from the catalog data.
            - If a product is listed as "Fitment Verified: YES", tell the user it's a confirmed, verified fit for their vehicle.
            - If asked about a product NOT in the compatible list, say we don't have confirmed fitment data for that product with their vehicle.
            - Keep responses concise (2-4 sentences) but informative. Include prices and SKUs.
            - You know the user's exact vehicle (year, make, model, trim) — use it by name, don't refer to "vehicle ID".
            {(contextParts.Count > 0 ? "\n\nCATALOG DATA:\n" + string.Join("\n\n", contextParts) : "")}

            Available product categories: Trailer Hitches, Ball Mounts, Wiring Harnesses, Brake Controllers,
            Tonneau Covers, Bed Liners, Bed Accessories, Running Boards, Fender Flares, Grille Guards,
            Headlights, Tail Lights, Fog Lights, Light Bars, Mud Flaps, Roof Racks.
            """;

        var messages = new List<object>();
        foreach (var msg in request.History.TakeLast(10))
        {
            messages.Add(new { role = msg.Role, content = msg.Content });
        }
        messages.Add(new { role = "user", content = request.Message });

        try
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Add("x-api-key", apiKey);
            client.DefaultRequestHeaders.Add("anthropic-version", "2023-06-01");

            var body = new
            {
                model = "claude-haiku-4-5-20251001",
                max_tokens = 500,
                system = systemPrompt,
                messages
            };

            var response = await client.PostAsJsonAsync("https://api.anthropic.com/v1/messages", body);
            var result = await response.Content.ReadFromJsonAsync<ClaudeApiResponse>();

            var text = result?.Content?.FirstOrDefault()?.Text ?? "I'm sorry, I couldn't process your request right now.";
            return Ok(ApiResponse<ChatResponse>.Ok(new ChatResponse(text)));
        }
        catch
        {
            return Ok(ApiResponse<ChatResponse>.Ok(new ChatResponse(
                "I'm having trouble connecting right now. Please try again in a moment.")));
        }
    }

    private record ClaudeApiResponse
    {
        public List<ClaudeContent>? Content { get; init; }
    }

    private record ClaudeContent
    {
        public string? Text { get; init; }
    }
}
