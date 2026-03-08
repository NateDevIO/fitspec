using Asp.Versioning;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json;

namespace FitSpec.API.Controllers;

[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/vin")]
public class VinDecoderController : ControllerBase
{
    private readonly IHttpClientFactory _httpClientFactory;
    private readonly IVehicleRepository _vehicleRepository;

    public VinDecoderController(
        IHttpClientFactory httpClientFactory,
        IVehicleRepository vehicleRepository)
    {
        _httpClientFactory = httpClientFactory;
        _vehicleRepository = vehicleRepository;
    }

    [HttpGet("{vin}/decode")]
    public async Task<ActionResult<ApiResponse<VinDecodeResultDto>>> DecodeVin(string vin)
    {
        if (string.IsNullOrWhiteSpace(vin) || vin.Length != 17)
            return BadRequest(ApiResponse<VinDecodeResultDto>.Fail("VIN must be exactly 17 characters."));

        try
        {
            var client = _httpClientFactory.CreateClient();
            var response = await client.GetAsync(
                $"https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVin/{vin}?format=json");

            if (!response.IsSuccessStatusCode)
                return Ok(ApiResponse<VinDecodeResultDto>.Ok(
                    new VinDecodeResultDto(vin, null, null, null, null, null, null, null)));

            var json = await response.Content.ReadAsStringAsync();
            var doc = JsonDocument.Parse(json);

            string? make = null, model = null, trim = null, bodyStyle = null, driveType = null;
            int? year = null;

            if (doc.RootElement.TryGetProperty("Results", out var results))
            {
                foreach (var item in results.EnumerateArray())
                {
                    var variableId = item.TryGetProperty("VariableId", out var vid) ? vid.GetInt32() : 0;
                    var value = item.TryGetProperty("Value", out var val) && val.ValueKind == JsonValueKind.String
                        ? val.GetString()
                        : null;

                    if (string.IsNullOrWhiteSpace(value)) continue;

                    switch (variableId)
                    {
                        case 26: make = value; break;       // Make
                        case 28: model = value; break;      // Model
                        case 29:                             // Model Year
                            if (int.TryParse(value, out var y)) year = y;
                            break;
                        case 38: bodyStyle = value; break;   // Body Class
                        case 15: driveType = value; break;   // Drive Type
                        case 14: trim = value; break;        // Trim
                    }
                }
            }

            // Try to match to a vehicle in our database
            int? matchedVehicleId = null;
            if (make != null && model != null && year.HasValue)
            {
                matchedVehicleId = await TryMatchVehicle(make, model, year.Value);
            }

            var result = new VinDecodeResultDto(vin, year, make, model, trim, bodyStyle, driveType, matchedVehicleId);
            return Ok(ApiResponse<VinDecodeResultDto>.Ok(result));
        }
        catch
        {
            return Ok(ApiResponse<VinDecodeResultDto>.Ok(
                new VinDecodeResultDto(vin, null, null, null, null, null, null, null)));
        }
    }

    private async Task<int?> TryMatchVehicle(string makeName, string modelName, int year)
    {
        var makes = await _vehicleRepository.GetMakesAsync();
        var matchedMake = makes.FirstOrDefault(m =>
            m.Name.Equals(makeName, StringComparison.OrdinalIgnoreCase));

        if (matchedMake is null) return null;

        var models = await _vehicleRepository.GetModelsByMakeAsync(matchedMake.Id);
        var matchedModel = models.FirstOrDefault(m =>
            m.Name.Equals(modelName, StringComparison.OrdinalIgnoreCase));

        if (matchedModel is null) return null;

        var years = await _vehicleRepository.GetYearsByMakeAndModelAsync(matchedMake.Id, matchedModel.Id);
        var matchedYear = years.FirstOrDefault(y => y.Year == year);

        return matchedYear?.VehicleId;
    }
}
