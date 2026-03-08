using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;
using System.Text;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/products")]
public class FitmentCertificateController : ControllerBase
{
    private readonly IProductRepository _productRepository;
    private readonly IVehicleRepository _vehicleRepository;

    public FitmentCertificateController(
        IProductRepository productRepository,
        IVehicleRepository vehicleRepository)
    {
        _productRepository = productRepository;
        _vehicleRepository = vehicleRepository;
    }

    [HttpGet("{productId:int}/fitment-certificate")]
    public async Task<IActionResult> GetFitmentCertificate(int productId, [FromQuery] int? vehicleId)
    {
        var product = await _productRepository.GetProductByIdAsync(productId);
        if (product is null)
            return NotFound(ApiResponse<string>.Fail("Product not found."));

        if (!vehicleId.HasValue)
            return BadRequest(ApiResponse<string>.Fail("Vehicle ID is required for a fitment certificate."));

        var vehicle = await _vehicleRepository.GetVehicleByIdAsync(vehicleId.Value);
        if (vehicle is null)
            return NotFound(ApiResponse<string>.Fail("Vehicle not found."));

        var compatibility = await _productRepository.CheckCompatibilityAsync(productId, vehicleId.Value);

        var vehicleName = $"{vehicle.Year} {vehicle.Make} {vehicle.Model}"
            + (vehicle.Trim != null ? $" {vehicle.Trim}" : "");

        var date = DateTime.UtcNow;
        var certNumber = GenerateCertificateNumber(productId, vehicleId.Value, date);

        var isCompatible = compatibility?.IsCompatible ?? false;
        var isVerified = compatibility?.IsVerified ?? false;
        var statusColor = isCompatible ? "#2e7d32" : "#c62828";
        var statusText = isCompatible ? "COMPATIBLE" : "NOT CONFIRMED";
        var statusBg = isCompatible ? "#e8f5e9" : "#ffebee";
        var verifiedBadge = isVerified
            ? "<span style='background:#2e7d32;color:white;padding:4px 12px;border-radius:4px;font-size:13px;font-weight:600'>VERIFIED</span>"
            : "<span style='background:#f57c00;color:white;padding:4px 12px;border-radius:4px;font-size:13px;font-weight:600'>UNVERIFIED</span>";

        var weightRow = product.Weight.HasValue
            ? $"<div class='detail-row'><span class='label'>Weight</span><span class='value'>{product.Weight:F1} lbs</span></div>"
            : "";
        var trimRow = vehicle.Trim != null
            ? $"<div class='detail-row'><span class='label'>Trim</span><span class='value'>{vehicle.Trim}</span></div>"
            : "";
        var bodyRow = vehicle.BodyStyle != null
            ? $"<div class='detail-row'><span class='label'>Body Style</span><span class='value'>{vehicle.BodyStyle}</span></div>"
            : "";
        var driveRow = vehicle.DriveType != null
            ? $"<div class='detail-row'><span class='label'>Drive Type</span><span class='value'>{vehicle.DriveType}</span></div>"
            : "";

        var fitmentSection = "";
        if (compatibility != null)
        {
            var diffRow = compatibility.InstallDifficulty.HasValue
                ? $"<div class='detail-row'><span class='label'>Install Difficulty</span><span class='value'>{compatibility.InstallDifficulty}/5</span></div>"
                : "";
            var notesRow = compatibility.FitmentNotes != null
                ? $"<div class='detail-row'><span class='label'>Notes</span><span class='value'>{compatibility.FitmentNotes}</span></div>"
                : "";
            fitmentSection = $@"<div class='detail-section' style='margin-bottom:20px'>
                <h3>Fitment Details</h3>
                {diffRow}
                {notesRow}
                <div class='detail-row'><span class='label'>Verification Status</span><span class='value'>{(isVerified ? "Verified" : "Unverified")}</span></div>
            </div>";
        }

        var html = $@"<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <title>Fitment Certificate - {product.Name} - FitSpec</title>
    <style>
        * {{ margin: 0; padding: 0; box-sizing: border-box; }}
        body {{ font-family: 'Segoe UI', Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 40px 32px; color: #333; }}
        .certificate {{ border: 3px solid #1a237e; border-radius: 12px; padding: 40px; position: relative; }}
        .certificate::before {{ content: ''; position: absolute; top: 6px; left: 6px; right: 6px; bottom: 6px; border: 1px solid #c5cae9; border-radius: 8px; pointer-events: none; }}
        .cert-header {{ text-align: center; margin-bottom: 32px; }}
        .cert-header h1 {{ color: #1a237e; font-size: 32px; letter-spacing: 2px; margin-bottom: 4px; }}
        .cert-header .subtitle {{ color: #666; font-size: 14px; text-transform: uppercase; letter-spacing: 3px; }}
        .cert-divider {{ height: 2px; background: linear-gradient(to right, transparent, #1a237e, transparent); margin: 24px 0; }}
        .status-banner {{ text-align: center; margin: 24px 0; padding: 16px; background: {statusBg}; border-radius: 8px; }}
        .status-banner h2 {{ color: {statusColor}; font-size: 28px; letter-spacing: 4px; }}
        .cert-details {{ display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin: 28px 0; }}
        .detail-section h3 {{ color: #1a237e; font-size: 14px; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 8px; border-bottom: 1px solid #e0e0e0; padding-bottom: 4px; }}
        .detail-row {{ display: flex; justify-content: space-between; padding: 4px 0; font-size: 14px; }}
        .detail-row .label {{ color: #666; }}
        .detail-row .value {{ font-weight: 600; }}
        .cert-footer {{ text-align: center; margin-top: 32px; padding-top: 20px; border-top: 1px solid #e0e0e0; }}
        .cert-number {{ font-family: monospace; font-size: 13px; color: #999; letter-spacing: 1px; }}
        .cert-date {{ font-size: 14px; color: #666; margin-top: 4px; }}
        @media print {{ body {{ padding: 20px; }} .certificate {{ border-width: 2px; padding: 32px; }} }}
    </style>
</head>
<body>
    <div class='certificate'>
        <div class='cert-header'>
            <h1>FitSpec</h1>
            <p class='subtitle'>Fitment Compatibility Certificate</p>
        </div>
        <div class='cert-divider'></div>
        <div class='status-banner'>
            <h2>{statusText}</h2>
            <p style='margin-top:8px'>{verifiedBadge}</p>
        </div>
        <div class='cert-details'>
            <div class='detail-section'>
                <h3>Product Information</h3>
                <div class='detail-row'><span class='label'>Name</span><span class='value'>{product.Name}</span></div>
                <div class='detail-row'><span class='label'>Brand</span><span class='value'>{product.Brand}</span></div>
                <div class='detail-row'><span class='label'>SKU</span><span class='value'>{product.SKU}</span></div>
                <div class='detail-row'><span class='label'>Category</span><span class='value'>{product.CategoryName}</span></div>
                <div class='detail-row'><span class='label'>Price</span><span class='value'>${product.Price:F2}</span></div>
                {weightRow}
            </div>
            <div class='detail-section'>
                <h3>Vehicle Information</h3>
                <div class='detail-row'><span class='label'>Vehicle</span><span class='value'>{vehicleName}</span></div>
                <div class='detail-row'><span class='label'>Year</span><span class='value'>{vehicle.Year}</span></div>
                <div class='detail-row'><span class='label'>Make</span><span class='value'>{vehicle.Make}</span></div>
                <div class='detail-row'><span class='label'>Model</span><span class='value'>{vehicle.Model}</span></div>
                {trimRow}{bodyRow}{driveRow}
            </div>
        </div>
        {fitmentSection}
        <div class='cert-divider'></div>
        <div class='cert-footer'>
            <p class='cert-number'>Certificate No: {certNumber}</p>
            <p class='cert-date'>Issued: {date:MMMM dd, yyyy} at {date:HH:mm} UTC</p>
            <p style='margin-top:12px;font-size:11px;color:#999'>This certificate is generated by FitSpec and confirms fitment compatibility based on available data.</p>
        </div>
    </div>
</body>
</html>";

        return Content(html, "text/html");
    }

    private static string GenerateCertificateNumber(int productId, int vehicleId, DateTime date)
    {
        var input = $"{productId}-{vehicleId}-{date:yyyyMMdd}";
        var hashBytes = SHA256.HashData(Encoding.UTF8.GetBytes(input));
        return $"FS-{BitConverter.ToString(hashBytes).Replace("-", "")[..12].ToUpper()}";
    }
}
