using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/products")]
public class InstallGuideController : ControllerBase
{
    private readonly IProductRepository _productRepository;
    private readonly IVehicleRepository _vehicleRepository;
    private readonly IConfiguration _configuration;
    private readonly IHttpClientFactory _httpClientFactory;

    public InstallGuideController(
        IProductRepository productRepository,
        IVehicleRepository vehicleRepository,
        IConfiguration configuration,
        IHttpClientFactory httpClientFactory)
    {
        _productRepository = productRepository;
        _vehicleRepository = vehicleRepository;
        _configuration = configuration;
        _httpClientFactory = httpClientFactory;
    }

    [HttpGet("{productId:int}/install-guide")]
    public async Task<IActionResult> GetInstallGuide(int productId, [FromQuery] int? vehicleId)
    {
        var product = await _productRepository.GetProductByIdAsync(productId);
        if (product is null)
            return NotFound(ApiResponse<string>.Fail("Product not found."));

        VehicleDetailDto? vehicle = null;
        CompatibilityCheckDto? compatibility = null;
        if (vehicleId.HasValue)
        {
            vehicle = await _vehicleRepository.GetVehicleByIdAsync(vehicleId.Value);
            compatibility = await _productRepository.CheckCompatibilityAsync(productId, vehicleId.Value);
        }

        var vehicleName = vehicle != null
            ? $"{vehicle.Year} {vehicle.Make} {vehicle.Model}" + (vehicle.Trim != null ? $" {vehicle.Trim}" : "")
            : "General Vehicle";

        var apiKey = _configuration["Claude:ApiKey"];
        string bodyContent;

        if (!string.IsNullOrEmpty(apiKey))
        {
            bodyContent = await GenerateAIGuide(product, vehicle, compatibility, vehicleName, apiKey);
        }
        else
        {
            bodyContent = GenerateStaticGuide(product, vehicle, compatibility, vehicleName);
        }

        var html = WrapInDocument($"Install Guide - {product.Name}", bodyContent);
        return Content(html, "text/html");
    }

    private async Task<string> GenerateAIGuide(
        ProductDetailDto product,
        VehicleDetailDto? vehicle,
        CompatibilityCheckDto? compatibility,
        string vehicleName,
        string apiKey)
    {
        var systemPrompt = $@"You are an expert automotive technician writing an installation guide.
Generate detailed HTML content (NOT a full HTML document, just the body content) for installing the following product.

Product: {product.Brand} {product.Name} (SKU: {product.SKU})
Category: {product.CategoryName}
Description: {product.Description}
Weight: {product.Weight?.ToString("F1") ?? "N/A"} lbs
Vehicle: {vehicleName}
{(vehicle?.DriveType != null ? $"Drive Type: {vehicle.DriveType}" : "")}
{(compatibility != null ? $"Install Difficulty: {compatibility.InstallDifficulty}/5" : "")}
{(compatibility?.FitmentNotes != null ? $"Fitment Notes: {compatibility.FitmentNotes}" : "")}

Include these sections with appropriate HTML tags (h2, h3, p, ul, ol, li, strong, etc.):
1. Overview and estimated time
2. Tools required (bulleted list)
3. Parts included (bulleted list)
4. Safety precautions (warning box)
5. Step-by-step instructions (numbered list with detailed sub-steps)
6. Post-installation checklist
7. Troubleshooting tips

Use semantic HTML. Add CSS classes: 'warning-box' for warnings, 'tool-list' for tools, 'step' for each major step.
Return ONLY the HTML body content, no <html>, <head>, or <body> tags.";

        try
        {
            var client = _httpClientFactory.CreateClient();
            client.DefaultRequestHeaders.Add("x-api-key", apiKey);
            client.DefaultRequestHeaders.Add("anthropic-version", "2023-06-01");

            var body = new
            {
                model = "claude-haiku-4-5-20251001",
                max_tokens = 2000,
                system = systemPrompt,
                messages = new[] { new { role = "user", content = $"Generate the installation guide for {product.Brand} {product.Name} on a {vehicleName}." } }
            };

            var response = await client.PostAsJsonAsync("https://api.anthropic.com/v1/messages", body);
            var result = await response.Content.ReadFromJsonAsync<ClaudeApiResponse>();

            var text = result?.Content?.FirstOrDefault()?.Text;
            if (!string.IsNullOrEmpty(text))
                return text;
        }
        catch
        {
            // Fall through to static guide
        }

        return GenerateStaticGuide(product, vehicle, compatibility, vehicleName);
    }

    private static string GenerateStaticGuide(
        ProductDetailDto product,
        VehicleDetailDto? vehicle,
        CompatibilityCheckDto? compatibility,
        string vehicleName)
    {
        var difficulty = compatibility?.InstallDifficulty ?? 3;
        var difficultyLabel = difficulty switch
        {
            1 => "Very Easy",
            2 => "Easy",
            3 => "Moderate",
            4 => "Difficult",
            5 => "Expert",
            _ => "Moderate"
        };
        var estimatedTime = difficulty switch
        {
            1 => "15-30 minutes",
            2 => "30-60 minutes",
            3 => "1-2 hours",
            4 => "2-4 hours",
            _ => "4+ hours"
        };
        var fitmentNote = compatibility?.FitmentNotes != null
            ? $"<p><strong>Fitment Notes:</strong> {compatibility.FitmentNotes}</p>"
            : "";

        return $@"<div class='guide-header'>
    <h1>{product.Brand} {product.Name}</h1>
    <p class='subtitle'>Installation Guide for {vehicleName}</p>
    <div class='meta-badges'>
        <span class='badge'>SKU: {product.SKU}</span>
        <span class='badge'>Category: {product.CategoryName}</span>
        <span class='badge'>Difficulty: {difficultyLabel} ({difficulty}/5)</span>
    </div>
</div>
<div class='section'>
    <h2>Overview</h2>
    <p>This guide covers the installation of the <strong>{product.Brand} {product.Name}</strong> on your <strong>{vehicleName}</strong>.</p>
    <p><strong>Estimated Time:</strong> {estimatedTime}</p>
    <p><strong>Skill Level:</strong> {difficultyLabel}</p>
    {fitmentNote}
</div>
<div class='section'>
    <h2>Tools Required</h2>
    <ul class='tool-list'>
        <li>Socket wrench set (metric and SAE)</li>
        <li>Torque wrench</li>
        <li>Screwdriver set (Phillips and flat-head)</li>
        <li>Trim removal tools</li>
        <li>Safety glasses and gloves</li>
        <li>Vehicle jack and jack stands (if undercarriage access needed)</li>
    </ul>
</div>
<div class='warning-box'>
    <h3>Safety Precautions</h3>
    <ul>
        <li>Ensure the vehicle is on a flat, stable surface before beginning installation.</li>
        <li>Disconnect the negative battery terminal if working near electrical components.</li>
        <li>Wear appropriate safety equipment including eye protection.</li>
        <li>Refer to your vehicle owner's manual for model-specific safety information.</li>
    </ul>
</div>
<div class='section'>
    <h2>Installation Steps</h2>
    <ol class='steps'>
        <li class='step'><h3>Preparation</h3><p>Unbox the {product.Name} and verify all components are present.</p></li>
        <li class='step'><h3>Vehicle Preparation</h3><p>Park on a level surface, engage parking brake, allow engine to cool.</p></li>
        <li class='step'><h3>Remove Existing Components</h3><p>If replacing an existing part, carefully remove it. Keep all hardware.</p></li>
        <li class='step'><h3>Test Fit</h3><p>Hold the {product.Name} in position to verify alignment with mounting points on your {vehicleName}.</p></li>
        <li class='step'><h3>Install the Product</h3><p>Secure the {product.Name} using the provided hardware. Start all bolts hand-tight before final torquing.</p></li>
        <li class='step'><h3>Final Torque and Inspection</h3><p>Torque all fasteners to manufacturer specifications. Inspect all connections.</p></li>
    </ol>
</div>
<div class='section'>
    <h2>Post-Installation Checklist</h2>
    <ul class='checklist'>
        <li>All fasteners torqued to specification</li>
        <li>No rattles or loose components</li>
        <li>Proper clearance from moving parts</li>
        <li>Electrical connections secure (if applicable)</li>
        <li>Test drive completed at low speed</li>
        <li>Re-check torque after 100 miles</li>
    </ul>
</div>
<div class='section'>
    <h2>Troubleshooting</h2>
    <ul>
        <li><strong>Mounting holes don't align:</strong> Verify you have the correct product for your {vehicleName}.</li>
        <li><strong>Rattling after installation:</strong> Re-torque all fasteners. Check for missing spacers or washers.</li>
        <li><strong>Clearance issues:</strong> Verify trim level compatibility.</li>
    </ul>
</div>";
    }

    private static string WrapInDocument(string title, string bodyContent)
    {
        return $@"<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <title>{title} - FitSpec</title>
    <style>
        * {{ margin: 0; padding: 0; box-sizing: border-box; }}
        body {{ font-family: 'Segoe UI', Arial, sans-serif; max-width: 900px; margin: 0 auto; padding: 32px 24px; color: #333; line-height: 1.6; }}
        .guide-header {{ border-bottom: 3px solid #1a237e; padding-bottom: 20px; margin-bottom: 28px; }}
        .guide-header h1 {{ color: #1a237e; font-size: 28px; margin-bottom: 4px; }}
        .subtitle {{ color: #666; font-size: 16px; margin-bottom: 12px; }}
        .meta-badges {{ display: flex; gap: 8px; flex-wrap: wrap; }}
        .badge {{ background: #e8eaf6; color: #1a237e; padding: 4px 12px; border-radius: 16px; font-size: 13px; font-weight: 500; }}
        .section {{ margin-bottom: 28px; }}
        .section h2 {{ color: #1a237e; font-size: 22px; margin-bottom: 12px; border-bottom: 1px solid #e0e0e0; padding-bottom: 6px; }}
        .section h3 {{ color: #333; font-size: 17px; margin-bottom: 6px; }}
        .section p {{ margin-bottom: 8px; }}
        .tool-list, .checklist {{ padding-left: 24px; }}
        .tool-list li, .checklist li {{ margin-bottom: 4px; }}
        .warning-box {{ background: #fff3e0; border-left: 4px solid #f57c00; padding: 16px 20px; border-radius: 4px; margin: 20px 0; }}
        .warning-box h3 {{ color: #e65100; margin-bottom: 8px; }}
        .warning-box ul {{ padding-left: 20px; }}
        .warning-box li {{ margin-bottom: 4px; }}
        .steps {{ padding-left: 0; list-style: none; counter-reset: step-counter; }}
        .step {{ background: #f5f7fa; border-radius: 8px; padding: 16px 20px; margin-bottom: 12px; counter-increment: step-counter; }}
        .step h3::before {{ content: 'Step ' counter(step-counter) ': '; color: #1a237e; }}
        .step p {{ margin-top: 6px; }}
        ol {{ padding-left: 24px; }}
        ol li {{ margin-bottom: 8px; }}
        ul {{ padding-left: 24px; }}
        ul li {{ margin-bottom: 4px; }}
        @media print {{ body {{ padding: 0; font-size: 12px; }} .step {{ break-inside: avoid; }} .warning-box {{ break-inside: avoid; }} }}
    </style>
</head>
<body>
    {bodyContent}
    <div style='margin-top:32px;padding-top:16px;border-top:1px solid #ddd;color:#888;font-size:12px;text-align:center'>
        <p>Generated by FitSpec — Vehicle Parts Fitment Finder</p>
    </div>
</body>
</html>";
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
