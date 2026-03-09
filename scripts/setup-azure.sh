#!/usr/bin/env bash
set -e

# =============================================================================
# FitSpec Azure Database Setup
# Seeds Azure SQL Database and Azure Cosmos DB (MongoDB API)
#
# Prerequisites:
#   - .NET SDK 10.0+ (for EF Core migrations)
#   - sqlcmd (install: https://learn.microsoft.com/en-us/sql/tools/sqlcmd)
#   - mongosh (install: https://www.mongodb.com/docs/mongodb-shell/install/)
#
# Usage:
#   ./scripts/setup-azure.sh \
#     --sql-connection "Server=yourserver.database.windows.net;Database=FitSpec;User Id=admin;Password=secret;Encrypt=true;TrustServerCertificate=false" \
#     --mongo-connection "mongodb://yourcosmosdb:password@yourcosmosdb.mongo.cosmos.azure.com:10255/fitspec?ssl=true&retrywrites=false"
#
# Or set environment variables:
#   AZURE_SQL_CONNECTION="..."
#   AZURE_MONGO_CONNECTION="..."
#   ./scripts/setup-azure.sh
# =============================================================================

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

SQL_CONN="${AZURE_SQL_CONNECTION:-}"
MONGO_CONN="${AZURE_MONGO_CONNECTION:-}"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --sql-connection) SQL_CONN="$2"; shift 2 ;;
    --mongo-connection) MONGO_CONN="$2"; shift 2 ;;
    --skip-sql) SKIP_SQL=1; shift ;;
    --skip-mongo) SKIP_MONGO=1; shift ;;
    --skip-migrations) SKIP_MIGRATIONS=1; shift ;;
    --help)
      echo "Usage: $0 [options]"
      echo ""
      echo "Options:"
      echo "  --sql-connection STRING     Azure SQL connection string"
      echo "  --mongo-connection STRING   Cosmos DB / MongoDB connection string"
      echo "  --skip-sql                  Skip SQL seed scripts"
      echo "  --skip-mongo                Skip MongoDB seed scripts"
      echo "  --skip-migrations           Skip EF Core migrations (tables already exist)"
      echo "  --help                      Show this help"
      exit 0
      ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

if [[ -z "$SQL_CONN" && -z "$SKIP_SQL" ]]; then
  echo "Error: Azure SQL connection string required."
  echo "  Use --sql-connection or set AZURE_SQL_CONNECTION"
  exit 1
fi

echo "=== FitSpec Azure Setup ==="
echo ""

# -------------------------------------------------------------------------
# Step 1: EF Core migrations (creates database schema)
# -------------------------------------------------------------------------
if [[ -z "$SKIP_MIGRATIONS" && -n "$SQL_CONN" ]]; then
  echo "[1/3] Applying EF Core migrations..."
  dotnet ef database update \
    --project src/FitSpec.Data \
    --startup-project src/FitSpec.API \
    --connection "$SQL_CONN"
  echo "  Schema created."
else
  echo "[1/3] Skipping EF Core migrations."
fi

# -------------------------------------------------------------------------
# Step 2: SQL seed scripts (stored procedures + data)
# -------------------------------------------------------------------------
if [[ -z "$SKIP_SQL" ]]; then
  echo "[2/3] Seeding Azure SQL Database..."

  # Extract server, user, password from connection string for sqlcmd
  SERVER=$(echo "$SQL_CONN" | grep -oP 'Server=\K[^;]+')
  DATABASE=$(echo "$SQL_CONN" | grep -oP 'Database=\K[^;]+')
  USER=$(echo "$SQL_CONN" | grep -oP 'User Id=\K[^;]+')
  PASSWORD=$(echo "$SQL_CONN" | grep -oP 'Password=\K[^;]+')

  if [[ -z "$SERVER" || -z "$DATABASE" || -z "$USER" || -z "$PASSWORD" ]]; then
    echo "  Error: Could not parse connection string. Expected format:"
    echo "  Server=...;Database=...;User Id=...;Password=..."
    exit 1
  fi

  for f in infra/seed/[0-1][0-9]*.sql; do
    echo "  Running $(basename "$f")..."
    sqlcmd -S "$SERVER" -U "$USER" -P "$PASSWORD" -d "$DATABASE" -i "$f" -I
  done
  echo "  SQL seeding complete."
else
  echo "[2/3] Skipping SQL seed scripts."
fi

# -------------------------------------------------------------------------
# Step 3: MongoDB seed scripts (reviews + catalog)
# -------------------------------------------------------------------------
if [[ -z "$SKIP_MONGO" && -n "$MONGO_CONN" ]]; then
  echo "[3/3] Seeding MongoDB (Cosmos DB)..."
  mongosh "$MONGO_CONN" < infra/seed/seed-mongo-reviews.js
  mongosh "$MONGO_CONN" < infra/seed/seed-mongo-catalog.js
  echo "  MongoDB seeding complete."
elif [[ -z "$SKIP_MONGO" && -z "$MONGO_CONN" ]]; then
  echo "[3/3] Skipping MongoDB — no connection string provided."
  echo "  Use --mongo-connection or set AZURE_MONGO_CONNECTION"
else
  echo "[3/3] Skipping MongoDB seed scripts."
fi

echo ""
echo "=== Azure setup complete! ==="
echo ""
echo "Verify your app settings include:"
echo "  ConnectionStrings__DefaultConnection = <your Azure SQL connection string>"
echo "  ConnectionStrings__MongoDb = <your Cosmos DB connection string>"
echo "  AllowedOrigins__0 = https://your-app.azurewebsites.net"
echo "  Claude__ApiKey = <your Anthropic API key> (optional)"
