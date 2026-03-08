using FitSpec.Core.DTOs;

namespace FitSpec.Core.Interfaces;

public interface IVehicleRepository
{
    Task<IEnumerable<MakeDto>> GetMakesAsync();
    Task<IEnumerable<ModelDto>> GetModelsByMakeAsync(int makeId);
    Task<IEnumerable<VehicleYearDto>> GetYearsByMakeAndModelAsync(int makeId, int modelId);
    Task<VehicleDetailDto?> GetVehicleByIdAsync(int vehicleId);
}
