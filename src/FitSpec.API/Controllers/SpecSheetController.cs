using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/products")]
public class SpecSheetController : ControllerBase
{
    private readonly IProductRepository _productRepository;
    private readonly IVehicleRepository _vehicleRepository;

    public SpecSheetController(
        IProductRepository productRepository,
        IVehicleRepository vehicleRepository)
    {
        _productRepository = productRepository;
        _vehicleRepository = vehicleRepository;
    }

    [HttpGet("{productId:int}/spec-sheet")]
    public async Task<IActionResult> GetSpecSheet(int productId, [FromQuery] int? vehicleId)
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
            : null;

        var specsRowsHtml = "";
        if (product.ExtendedSpecs != null)
        {
            foreach (var spec in product.ExtendedSpecs)
            {
                specsRowsHtml += $"<tr><td class='spec-label'>{spec.Key}</td><td class='spec-val'>{spec.Value}</td></tr>";
            }
        }

        var extendedSection = specsRowsHtml.Length > 0
            ? $"<div class='section'><h2>Extended Specifications</h2><table class='spec-table'>{specsRowsHtml}</table></div>"
            : "";

        var compatSection = "";
        if (vehicle != null && compatibility != null)
        {
            var statusColor = compatibility.IsCompatible ? "#2e7d32" : "#c62828";
            var statusText = compatibility.IsCompatible ? "Compatible" : "Not Confirmed";
            var rows = $"<tr><td class='spec-label'>Vehicle</td><td class='spec-val'>{vehicleName}</td></tr>";
            if (vehicle.BodyStyle != null)
                rows += $"<tr><td class='spec-label'>Body Style</td><td class='spec-val'>{vehicle.BodyStyle}</td></tr>";
            if (vehicle.DriveType != null)
                rows += $"<tr><td class='spec-label'>Drive Type</td><td class='spec-val'>{vehicle.DriveType}</td></tr>";
            if (vehicle.TowCapacityLbs.HasValue)
                rows += $"<tr><td class='spec-label'>Tow Capacity</td><td class='spec-val'>{vehicle.TowCapacityLbs:N0} lbs</td></tr>";
            rows += $"<tr><td class='spec-label'>Fitment Status</td><td class='spec-val' style='color:{statusColor};font-weight:600'>{statusText}</td></tr>";
            rows += $"<tr><td class='spec-label'>Verified</td><td class='spec-val'>{(compatibility.IsVerified ? "Yes" : "No")}</td></tr>";
            if (compatibility.InstallDifficulty.HasValue)
                rows += $"<tr><td class='spec-label'>Install Difficulty</td><td class='spec-val'>{compatibility.InstallDifficulty}/5</td></tr>";
            if (compatibility.FitmentNotes != null)
                rows += $"<tr><td class='spec-label'>Fitment Notes</td><td class='spec-val'>{compatibility.FitmentNotes}</td></tr>";
            compatSection = $"<div class='section'><h2>Vehicle Compatibility</h2><table class='spec-table'>{rows}</table></div>";
        }

        var weightRow = product.Weight.HasValue
            ? $"<tr><td class='spec-label'>Weight</td><td class='spec-val'>{product.Weight:F1} lbs</td></tr>"
            : "";

        var descriptionSection = product.Description != null
            ? $"<p>{product.Description}</p>"
            : "";

        var date = DateTime.UtcNow.ToString("MMMM dd, yyyy");

        var html = $@"<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <title>Spec Sheet - {product.Name} - FitSpec</title>
    <style>
        * {{ margin: 0; padding: 0; box-sizing: border-box; }}
        body {{ font-family: 'Segoe UI', Arial, sans-serif; max-width: 900px; margin: 0 auto; padding: 32px 24px; color: #333; line-height: 1.6; }}
        .spec-header {{ display: flex; justify-content: space-between; align-items: flex-start; border-bottom: 3px solid #1a237e; padding-bottom: 20px; margin-bottom: 28px; }}
        .spec-header h1 {{ color: #1a237e; font-size: 26px; }}
        .spec-header .brand {{ color: #666; font-size: 14px; margin-top: 2px; }}
        .spec-header .date {{ color: #999; font-size: 13px; text-align: right; }}
        .section {{ margin-bottom: 28px; }}
        .section h2 {{ color: #1a237e; font-size: 20px; margin-bottom: 12px; border-bottom: 1px solid #e0e0e0; padding-bottom: 6px; }}
        .spec-table {{ width: 100%; border-collapse: collapse; font-size: 14px; }}
        .spec-label {{ padding: 8px 12px; border-bottom: 1px solid #eee; color: #666; font-weight: 500; width: 40%; }}
        .spec-val {{ padding: 8px 12px; border-bottom: 1px solid #eee; }}
        .product-overview {{ background: #f5f7fa; border-radius: 8px; padding: 20px; margin-bottom: 24px; }}
        .product-overview p {{ margin-bottom: 8px; }}
        .sku-badge {{ background: #1a237e; color: white; padding: 3px 10px; border-radius: 4px; font-size: 12px; font-weight: 600; font-family: monospace; }}
        @media print {{ body {{ padding: 0; font-size: 12px; }} .section {{ break-inside: avoid; }} }}
    </style>
</head>
<body>
    <div class='spec-header'>
        <div>
            <h1>{product.Name}</h1>
            <p class='brand'>{product.Brand} &mdash; <span class='sku-badge'>{product.SKU}</span></p>
        </div>
        <div class='date'>
            <p>{date}</p>
            <p>Product Spec Sheet</p>
        </div>
    </div>
    <div class='product-overview'>{descriptionSection}</div>
    <div class='section'>
        <h2>Product Details</h2>
        <table class='spec-table'>
            <tr><td class='spec-label'>SKU</td><td class='spec-val'>{product.SKU}</td></tr>
            <tr><td class='spec-label'>Brand</td><td class='spec-val'>{product.Brand}</td></tr>
            <tr><td class='spec-label'>Category</td><td class='spec-val'>{product.CategoryName}</td></tr>
            <tr><td class='spec-label'>Price</td><td class='spec-val'>${product.Price:F2}</td></tr>
            {weightRow}
            <tr><td class='spec-label'>Verified</td><td class='spec-val'>{(product.IsVerified ? "Yes" : "No")}</td></tr>
        </table>
    </div>
    {extendedSection}
    {compatSection}
    <div style='margin-top:32px;padding-top:16px;border-top:1px solid #ddd;color:#888;font-size:12px;text-align:center'>
        <p>Generated by FitSpec — Vehicle Parts Fitment Finder</p>
    </div>
</body>
</html>";

        return Content(html, "text/html");
    }
}
