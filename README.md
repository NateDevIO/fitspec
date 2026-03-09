# FitSpec — Vehicle Parts Fitment Finder

Full-stack automotive parts fitment application built with **Angular 19**, **ASP.NET Core 10**, **SQL Server**, and **MongoDB**. Provides verified compatibility data for aftermarket parts, accessories, and modifications across 150+ products and 30 brands.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Angular 19 (standalone components, signals, Material 3) |
| Backend | ASP.NET Core 10, Dapper + EF Core, API versioning |
| SQL Database | SQL Server 2022 (vehicles, products, fitment mappings, orders) |
| Document Store | MongoDB 7 (reviews, product catalog, Q&A) |
| ML | ML.NET (product recommendations) |
| Real-time | SignalR (inventory updates) |
| AI | Claude API (fitment assistant, install guides) |
| Infrastructure | Docker Compose (4 containers), nginx reverse proxy |

## Architecture

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│  Angular UI  │────▶│  nginx :80   │────▶│  .NET API   │
│  (SPA)       │     │  /api proxy  │     │  :5062      │
└─────────────┘     └──────────────┘     └──────┬──────┘
                                                │
                                    ┌───────────┴───────────┐
                                    │                       │
                              ┌─────▼─────┐          ┌─────▼─────┐
                              │ SQL Server │          │  MongoDB  │
                              │  :1433     │          │  :27017   │
                              └───────────┘          └───────────┘
```

The Angular app is served by nginx, which also reverse-proxies `/api/` and `/hubs/` requests to the .NET API container. All API calls from the frontend use relative URLs (`/api/v1/...`).

## Features

1. **Vehicle Selector** — Year/Make/Model cascading dropdowns with URL-persisted state
2. **Product Catalog** — Filterable grid with compatibility badges, category navigation
3. **Product Detail** — Specs, compatibility check, install difficulty, pricing
4. **Product Comparison** — Side-by-side compare with persistent tray
5. **Garage Manager** — Save multiple vehicles to localStorage
6. **AI Fitment Assistant** — Claude-powered Q&A about parts and compatibility
7. **Community Builds** — Popular product combinations by vehicle
8. **Product Q&A** — User questions stored in MongoDB
9. **Reviews** — Star ratings with MongoDB storage
10. **Real-time Inventory** — SignalR push updates for stock levels
11. **Install Guides** — AI-generated or static HTML installation instructions
12. **Required Accessories** — "Frequently Bought Together" cross-sell
13. **Install Cost Estimator** — Difficulty-based labor cost ranges
14. **Fitment Certificate** — SHA256-verified PDF certificate
15. **Spec Sheets** — Vehicle-specific product specification documents
16. **VIN Decoder** — NHTSA API integration with database matching
17. **Price Drop Alerts** — Subscribe to price change notifications
18. **Build Sheet PDF** — Export full build as printable document
19. **Admin Dashboard** — Product CRUD, review moderation, analytics
20. **Progressive Web App** — Installable with offline-capable service worker
21. **Dark Mode** — System-aware theme toggle with CSS custom properties
22. **Global Search** — Header autocomplete with typeahead

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Git](https://git-scm.com/)

## Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/<your-username>/fitspec.git
   cd fitspec
   ```

2. **Create a `.env` file** (optional — only needed for the AI Assistant feature)
   ```bash
   # .env
   CLAUDE_API_KEY=your-api-key-here
   ```
   Get a key at [console.anthropic.com](https://console.anthropic.com/settings/keys).

3. **Start all services**
   ```bash
   docker compose up -d
   ```
   This builds and starts 4 containers:
   - `fitspec-sql` — SQL Server 2022
   - `fitspec-mongo` — MongoDB 7
   - `fitspec-api` — ASP.NET Core API
   - `fitspec-ui` — Angular + nginx

4. **Seed the database**
   ```bash
   bash scripts/setup-dev.sh
   ```
   This applies EF Core migrations, runs stored procedures, and loads seed data into both SQL Server and MongoDB.

5. **Open the app**
   - UI: [http://localhost:4200](http://localhost:4200)
   - API (Swagger): [http://localhost:5062/swagger](http://localhost:5062/swagger) (development only)
   - Admin panel: [http://localhost:4200/admin](http://localhost:4200/admin)

## Project Structure

```
fitspec/
├── docker-compose.yml          # 4-service orchestration
├── .env                        # Secrets (gitignored)
├── scripts/
│   └── setup-dev.sh            # Database setup & seeding
├── infra/
│   └── seed/                   # SQL + MongoDB seed scripts
├── src/
│   ├── FitSpec.API/            # ASP.NET Core 10 API
│   │   ├── Controllers/        # REST endpoints (versioned)
│   │   ├── Hubs/               # SignalR hubs
│   │   ├── Middleware/         # Exception handling
│   │   └── Dockerfile
│   ├── FitSpec.Core/           # Domain models, DTOs, interfaces
│   ├── FitSpec.Data/           # Repositories (Dapper + EF Core)
│   │   ├── Migrations/         # EF Core migrations
│   │   └── Repositories/
│   ├── FitSpec.ML/             # ML.NET recommendation engine
│   └── fitspec-ui/             # Angular 19 SPA
│       ├── src/app/
│       │   ├── core/           # Services, state, interceptors, models
│       │   └── features/       # Feature components
│       ├── nginx.conf          # Reverse proxy config
│       └── Dockerfile
└── tests/                      # Test projects
```

## Configuration

### Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `CLAUDE_API_KEY` | Anthropic API key for AI features | No (AI features disabled without it) |
| `ConnectionStrings__DefaultConnection` | SQL Server connection string | Set in docker-compose.yml |
| `ConnectionStrings__MongoDb` | MongoDB connection string | Set in docker-compose.yml |
| `AllowedOrigins__0` | CORS allowed origin | Defaults to `http://localhost:4200` |

### Azure Deployment

When deploying to Azure, configure these as **App Settings** or environment variables:

- `ConnectionStrings__DefaultConnection` — Azure SQL connection string
- `ConnectionStrings__MongoDb` — Azure Cosmos DB (MongoDB API) or MongoDB Atlas connection string
- `CLAUDE_API_KEY` — Anthropic API key
- `AllowedOrigins__0` — Your Azure app URL (e.g., `https://fitspec.azurewebsites.net`)

The `.env` file is gitignored and must be recreated in each environment.

## API Endpoints

All endpoints are versioned under `/api/v1/`.

| Endpoint | Description |
|----------|-------------|
| `GET /api/v1/vehicles/makes` | List vehicle makes |
| `GET /api/v1/vehicles/makes/{id}/models` | Models for a make |
| `GET /api/v1/vehicles/{makeId}/{modelId}` | Vehicles by make + model |
| `GET /api/v1/categories` | Product categories |
| `GET /api/v1/products` | Product listing (filterable) |
| `GET /api/v1/products/{id}` | Product detail |
| `GET /api/v1/products/{id}/compatibility/{vehicleId}` | Fitment check |
| `GET /api/v1/products/{id}/recommendations` | ML recommendations |
| `GET /api/v1/products/{id}/accessories` | Required accessories |
| `GET /api/v1/products/{id}/reviews` | Product reviews |
| `POST /api/v1/products/{id}/reviews` | Submit review |
| `GET /api/v1/products/{id}/qa` | Product Q&A |
| `POST /api/v1/products/{id}/qa` | Ask a question |
| `GET /api/v1/search?q=...` | Global search |
| `GET /api/v1/admin/dashboard` | Admin statistics |
| `GET /api/v1/vin/{vin}/decode` | VIN decoder |
| `POST /api/v1/assistant` | AI fitment assistant |
| `WS /hubs/inventory` | SignalR inventory hub |

## Development

### Rebuild after code changes

```bash
# Rebuild both containers
docker compose up -d --build api ui

# Rebuild just the API
docker compose up -d --build api

# Rebuild just the UI
docker compose up -d --build ui
```

### View logs

```bash
docker compose logs -f api    # API logs
docker compose logs -f ui     # nginx logs
```

### Stop all services

```bash
docker compose down           # Stop containers (keep data)
docker compose down -v        # Stop and delete volumes (reset databases)
```

## License

This is a portfolio project. All rights reserved.
