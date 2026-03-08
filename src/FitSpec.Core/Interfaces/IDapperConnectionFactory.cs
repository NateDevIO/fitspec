using System.Data;

namespace FitSpec.Core.Interfaces;

public interface IDapperConnectionFactory
{
    IDbConnection CreateConnection();
}
