using System.Data;
using Dapper;
using FitSpec.Core.DTOs;
using FitSpec.Core.Interfaces;

namespace FitSpec.Data.Repositories;

public class VehicleRepository : IVehicleRepository
{
    private readonly IDapperConnectionFactory _connectionFactory;

    public VehicleRepository(IDapperConnectionFactory connectionFactory)
    {
        _connectionFactory = connectionFactory;
    }

    public async Task<IEnumerable<MakeDto>> GetMakesAsync()
    {
        using var connection = _connectionFactory.CreateConnection();
        return await connection.QueryAsync<MakeDto>(
            "sp_GetVehicleCascade",
            new { MakeId = (int?)null, ModelId = (int?)null },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<IEnumerable<ModelDto>> GetModelsByMakeAsync(int makeId)
    {
        using var connection = _connectionFactory.CreateConnection();
        return await connection.QueryAsync<ModelDto>(
            "sp_GetVehicleCascade",
            new { MakeId = makeId, ModelId = (int?)null },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<IEnumerable<VehicleYearDto>> GetYearsByMakeAndModelAsync(int makeId, int modelId)
    {
        using var connection = _connectionFactory.CreateConnection();
        return await connection.QueryAsync<VehicleYearDto>(
            "sp_GetVehicleCascade",
            new { MakeId = makeId, ModelId = modelId },
            commandType: CommandType.StoredProcedure);
    }

    public async Task<VehicleDetailDto?> GetVehicleByIdAsync(int vehicleId)
    {
        using var connection = _connectionFactory.CreateConnection();
        return await connection.QuerySingleOrDefaultAsync<VehicleDetailDto>(
            @"SELECT v.Id, v.Year, mk.Name AS Make, md.Name AS Model,
                     v.Trim, v.BodyStyle, v.DriveType, v.TowCapacityLbs
              FROM Vehicles v
              INNER JOIN Makes mk ON v.MakeId = mk.Id
              INNER JOIN Models md ON v.ModelId = md.Id
              WHERE v.Id = @VehicleId",
            new { VehicleId = vehicleId });
    }
}
