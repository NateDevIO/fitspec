# FitSpec — Automotive Parts Fitment & Recommendation Engine

**[Live Demo → fitspec.natedev.io](https://fitspec.natedev.io)**

FitSpec solves the automotive aftermarket's core conversion problem: getting the right part on the right vehicle, every time. Users select their vehicle by year, make, model, and trim, then browse a catalog of verified-compatible parts across multiple categories — with AI-powered recommendations, install guides, and a fitment assistant built in.

The fitment data model reflects how aftermarket automotive parts actually work: year/make/model/trim specificity, receiver classes, bulb types, wiring configurations, and cross-category compatibility patterns. Every architectural decision maps to a real e-commerce outcome.

---

## Tech Stack

| Layer | Technology | Why |
|-------|-----------|-----|
| **Frontend** | Angular 21 (standalone components, signals, Material 3) | Enterprise-standard SPA framework with custom theming |
| **Backend** | ASP.NET Core 10, Dapper + EF Core, API versioning | Current release, production-grade REST API |
| **SQL Database** | SQL Server 2022 / Azure SQL | Relational fitment data with stored procedures via Dapper for performance-critical queries |
| **Document Store** | MongoDB 7 / Atlas | Flexible schema for reviews, Q&A, and category-specific product metadata |
| **ML** | ML.NET (matrix factorization) | In-process recommendations with no external API dependencies |
| **Real-time** | SignalR | Inventory push updates |
| **AI** | Anthropic Claude API | Fitment assistant chat, dynamic install guides, certificates, spec sheets |
| **Infrastructure** | Docker Compose (local), Azure App Service + Static Web Apps (prod) | Full production deployment with CI/CD |

---

## Architecture

### Production (Azure)

```
┌─────────────────────────────────────────────────────────────────────┐
│                        Azure Static Web Apps                        │
│                     Angular 21 SPA (CDN + SSL)                      │
│                      fitspec.natedev.io                             │
└──────────────────────────────┬──────────────────────────────────────┘
                               │ HTTPS
                               ▼
┌─────────────────────────────────────────────────────────────────────┐
│                      Azure App Service (B1)                         │
│                   ASP.NET Core .NET 10 Web API                      │
│                    fitspec-api.azurewebsites.net                    │
│                                                                     │
│  ┌──────────────┐  ┌──────────────┐  ┌───────────────────────────┐ │
│  │  Controllers │  │   ML.NET     │  │   Claude API Integration  │ │
│  │  & Middleware │  │  Prediction  │  │   (Fitment Assistant,     │ │
│  │              │  │   Engine     │  │    Install Guides,        │ │
│  │              │  │              │  │    Certificates)          │ │
│  └──────┬───────┘  └──────┬───────┘  └───────────────────────────┘ │
│         │                 │                                         │
│  ┌──────┴─────────────────┴──────────────────────────────────────┐ │
│  │              Data Access Layer (Dapper + EF Core)              │ │
│  └──────┬──────────────────────────────────┬─────────────────────┘ │
└─────────┼──────────────────────────────────┼───────────────────────┘
          │                                  │
          ▼                                  ▼
┌──────────────────────┐        ┌──────────────────────┐
│   Azure SQL Database │        │   MongoDB Atlas (M0)  │
│                      │        │                       │
│  • Vehicles (1,747)  │        │  • Product Reviews    │
│  • Products (150)    │        │  • Q&A Threads (330)  │
│  • FitmentMappings   │        │  • Extended Catalog   │
│    (174,295)         │        │    Metadata            │
│  • Orders (4,500)    │        │                       │
│  • Stored Procedures │        │                       │
└──────────────────────┘        └──────────────────────┘
```

### Local Development (Docker Compose)

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

---

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

---

## Design Decisions

### Polyglot Persistence (SQL Server + MongoDB)
Fitment data is deeply relational — vehicles, products, and their many-to-many compatibility mappings require referential integrity and performant joins. Reviews, Q&A, and extended product metadata have variable schemas (a hitch and a headlight have completely different spec sheets) and are naturally document-oriented. Using both databases is an intentional architectural choice, not complexity for its own sake.

### Dapper + EF Core Hybrid
Dapper handles the performance-critical fitment queries via stored procedures — these power the core user experience and need to be fast. EF Core handles migrations, schema management, and simpler CRUD operations where developer velocity matters more than raw query speed. This reflects how production .NET applications actually make data access decisions.

### ML.NET Over External APIs
The recommendation engine runs entirely within the .NET ecosystem using ML.NET, with no external API dependencies or Python services. The trained model is loaded once at startup and serves predictions in-process, keeping response times low.

---

## Data Model

The core schema centers on the `FitmentMappings` junction table, which links vehicles to compatible products. This many-to-many relationship is the heart of the application.

```
Makes (30) ──┐
             ├── Vehicles (1,747) ──── FitmentMappings (174,295) ──── Products (150)
Models (180) ┘                                                            │
                                                                    Categories (20)

Orders (4,500) ──── OrderItems (7,464)  →  ML.NET Training Data
```

Stored procedures (`sp_GetCompatibleProducts`, `sp_GetVehicleCascade`, `sp_GetCategoryBreakdown`) handle the performance-critical fitment queries via Dapper.

---

## Quick Start

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Git](https://git-scm.com/)

### Run the Full Stack

1. **Clone the repository**
   ```bash
   git clone https://github.com/NateDevIO/fitspec.git
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

### Run Tests

```bash
dotnet test tests/FitSpec.Tests
```

---

## Azure Deployment

FitSpec is deployed on Azure's free and low-cost tiers:

| Service | Resource | Tier | Monthly Cost |
|---------|----------|------|-------------|
| API | Azure App Service | B1 Basic | ~$13 |
| Frontend | Azure Static Web Apps | Free | $0 |
| SQL Database | Azure SQL | Free (32GB) | $0 |
| Document DB | MongoDB Atlas | M0 Free (512MB) | $0 |
| **Total** | | | **~$13/mo** |

CI/CD is handled by GitHub Actions workflows:
- **FitSpec CI** — builds and tests on every push
- **Deploy API to Azure** — publishes to App Service on pushes to `src/`
- **Azure Static Web Apps CI/CD** — auto-deploys the Angular SPA

---

## Project Structure

```
fitspec/
├── docker-compose.yml          # 4-service orchestration
├── .env                        # Secrets (gitignored)
├── .github/workflows/          # CI/CD pipeline definitions
├── scripts/
│   └── setup-dev.sh            # Database setup & seeding
├── infra/
│   └── seed/                   # SQL + MongoDB seed scripts (00-18)
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
│   └── fitspec-ui/             # Angular 21 SPA
│       ├── src/app/
│       │   ├── core/           # Services, state, interceptors, models
│       │   └── features/       # Feature components
│       ├── nginx.conf          # Reverse proxy config
│       └── Dockerfile
└── tests/
    └── FitSpec.Tests/          # xUnit unit & integration tests
```

## Configuration

### Environment Variables

| Variable | Description | Required |
|----------|-------------|----------|
| `CLAUDE_API_KEY` | Anthropic API key for AI features | No (AI features disabled without it) |
| `ConnectionStrings__DefaultConnection` | SQL Server connection string | Set in docker-compose.yml |
| `ConnectionStrings__MongoDb` | MongoDB connection string | Set in docker-compose.yml |
| `AllowedOrigins__0` | CORS allowed origin | Defaults to `http://localhost:4200` |

When deploying to Azure, configure these as **App Settings** or environment variables:

- `ConnectionStrings__DefaultConnection` — Azure SQL connection string
- `ConnectionStrings__MongoDb` — MongoDB Atlas connection string
- `CLAUDE_API_KEY` — Anthropic API key
- `AllowedOrigins__0` — Your Azure app URL (e.g., `https://fitspec.natedev.io`)

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

---

## About the Developer

Built by **Nate Allen** — a software engineer with 12+ years of e-commerce experience who understands that fitment accuracy is the difference between a conversion and a return.

- **Portfolio:** [natedev.io](https://natedev.io)
- **LinkedIn:** [linkedin.com/in/natedev](https://linkedin.com/in/natedev)
- **GitHub:** [github.com/NateDevIO](https://github.com/NateDevIO)

---

## License

This project is a portfolio demonstration and is not intended for commercial use.
