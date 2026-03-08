#!/usr/bin/env bash
set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

echo "=== FitSpec Dev Setup ==="

# 1. Start databases
echo "[1/6] Starting SQL Server and MongoDB..."
docker compose up sqlserver mongodb -d

# 2. Wait for SQL Server to be healthy
echo "[2/6] Waiting for SQL Server..."
until docker exec fitspec-sql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "FitSpec_Dev123!" -C -Q "SELECT 1" -b > /dev/null 2>&1; do
  sleep 2
done
echo "  SQL Server is ready."

# 3. Apply EF Core migrations (creates database + tables)
echo "[3/6] Applying EF Core migrations..."
dotnet ef database update --project src/FitSpec.Data --startup-project src/FitSpec.API

# 4. Run stored procedures
echo "[4/6] Creating stored procedures..."
docker exec -i fitspec-sql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "FitSpec_Dev123!" -C -d FitSpec < infra/seed/00-stored-procedures.sql

# 5. Seed SQL data
echo "[5/6] Seeding SQL data..."
for f in infra/seed/[0-1][0-9]*.sql; do
  echo "  Running $f..."
  docker exec -i fitspec-sql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "FitSpec_Dev123!" -C -d FitSpec < "$f"
done

# 6. Seed MongoDB
echo "[6/6] Seeding MongoDB..."
docker exec -i fitspec-mongo mongosh < infra/seed/seed-mongo-reviews.js
docker exec -i fitspec-mongo mongosh < infra/seed/seed-mongo-catalog.js

echo ""
echo "=== Setup complete! ==="
echo ""
echo "Start the API:     cd src/FitSpec.API && dotnet run"
echo "Start Angular:     cd src/fitspec-ui && npx ng serve"
echo "Open browser:      http://localhost:4200"
echo "Swagger:           http://localhost:5062/swagger"
