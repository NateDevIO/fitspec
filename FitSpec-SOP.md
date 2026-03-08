# FitSpec — Automotive Parts Fitment & Recommendation Engine

**Standard Operating Procedure**

A Full-Stack .NET + Angular Portfolio Project
Targeting: E-Commerce & Automotive Aftermarket Software Engineering Roles

| | |
|---|---|
| **Author** | Nate |
| **Version** | 2.0 |
| **Date** | March 2026 |

---

## 1. Project Overview

This document defines the architecture, implementation plan, design standards, and deployment strategy for **FitSpec** — a full-stack web application that solves the universal automotive aftermarket problem: helping customers find parts and accessories that are verified compatible with their specific vehicle. The platform supports any fitment vertical (towing, exterior, lighting, performance, interior) and demonstrates how a single architecture can power fitment logic across an entire parts catalog.

### 1.1 Purpose & Strategic Alignment

This project serves as a portfolio piece targeting software engineering roles at e-commerce and automotive aftermarket companies. The architecture and domain model are designed to be immediately recognizable to companies like etrailer, AutoZone, O'Reilly Auto Parts, RealTruck, Carvana, or any retailer selling vehicle-specific products. The tech stack (.NET Core, Angular, SQL Server, MongoDB, Dapper) was selected to match common enterprise e-commerce stacks, with ML.NET adding an intelligence layer that differentiates it from a standard CRUD app.

### 1.2 Key Objectives

- Demonstrate full-stack proficiency in .NET Core, Angular, TypeScript, and SQL Server
- Showcase product thinking by solving a real e-commerce fitment/compatibility problem that generalizes across the automotive aftermarket
- Implement ML.NET-powered recommendation engine ("Frequently Bought Together")
- Include automated testing (xUnit, Playwright) and CI/CD pipeline configuration
- Deliver a visually polished, production-grade UI that reflects design craftsmanship
- Build a domain model flexible enough to support any fitment vertical, not just one product category

---

## 2. Technology Stack

Every technology choice maps to common requirements across e-commerce engineering roles. The stack is intentionally enterprise-grade and production-oriented.

| Layer | Technology | Why This Choice | Purpose |
|-------|-----------|-----------------|---------|
| Frontend | Angular 17+ / TypeScript | Dominant in enterprise e-commerce | SPA with cascading vehicle selector, product catalog, and recommendation UI |
| Backend API | ASP.NET Core 8 Web API | Industry standard for .NET shops | RESTful API serving fitment data, product info, and ML predictions |
| ORM / Data Access | Dapper + EF Core (hybrid) | Shows pragmatic tool selection | Dapper for perf-critical queries; EF Core for migrations and CRUD scaffolding |
| Primary DB | SQL Server 2022 | Enterprise e-commerce standard | Relational store for vehicles, products, fitment mappings, orders |
| Document DB | MongoDB | Flexible catalog metadata | Product reviews, unstructured specs, install guides — data that varies by category |
| ML / AI | ML.NET | Native .NET ML, no Python dependency | Recommendation model trained on simulated order co-occurrence data |
| Testing | xUnit, Playwright | Industry standard .NET testing | Unit tests for fitment logic, integration tests for API, E2E for critical flows |
| CI/CD | GitHub Actions | Free, widely adopted | Automated build, test, and deploy pipeline |
| Cloud Platform | Azure (App Service, Static Web Apps, Azure SQL, Key Vault) | Enterprise .NET standard | Production deployment with managed infrastructure, secrets management, and CDN |

---

## 3. System Architecture

### 3.1 High-Level Architecture

The system follows a clean three-tier architecture with clear separation of concerns. The Angular SPA communicates exclusively with the .NET Core Web API via REST. The API layer orchestrates between SQL Server (structured fitment/order data), MongoDB (reviews and flexible content), and the ML.NET recommendation service.

```
[ Angular SPA ]  →  [ ASP.NET Core API ]  →  [ SQL Server | MongoDB | ML.NET ]
```

### 3.2 Project Structure

Use a monorepo with the following top-level layout. This keeps the solution cohesive while maintaining clear boundaries between layers.

| Directory / Project | Description |
|---------------------|-------------|
| `/src/FitSpec.API` | ASP.NET Core Web API project (controllers, middleware, DI config) |
| `/src/FitSpec.Core` | Domain models, interfaces, DTOs — no external dependencies |
| `/src/FitSpec.Data` | Dapper repositories, EF DbContext, SQL Server + MongoDB data access |
| `/src/FitSpec.ML` | ML.NET model training pipeline, prediction service, data generators |
| `/src/fitspec-ui/` | Angular 17+ SPA (standalone components, Angular Material) |
| `/tests/FitSpec.Tests` | xUnit unit + integration tests for API and data layer |
| `/tests/FitSpec.E2E` | Playwright end-to-end test suite |
| `/infra/` | Docker Compose, GitHub Actions workflows, seed scripts |

---

## 4. Data Model

### 4.1 SQL Server Schema (Relational Core)

The relational schema handles the core fitment logic. The key design challenge is the many-to-many relationship between vehicles and products, mediated through the FitmentMapping table. This is the heart of the application — and it's designed to be category-agnostic, so the same schema supports towing parts, lighting, exterior accessories, or any future vertical.

#### 4.1.1 Core Tables

| Table | Key Columns | Type | Notes |
|-------|-------------|------|-------|
| **Vehicles** | Id, Year, MakeId, ModelId, Trim, BodyStyle, DriveType, TowCapacityLbs | Lookup / Reference | Normalized: Makes and Models are separate FK tables. Trim, BodyStyle, and DriveType enable precise fitment matching. |
| **Makes** | Id, Name, Slug | Lookup | Ford, Chevrolet, Toyota, RAM, Honda, Jeep, etc. |
| **Models** | Id, MakeId, Name, Slug | Lookup | FK to Makes. F-150, Silverado, Tacoma, Civic, Wrangler, etc. |
| **Categories** | Id, Name, Slug, ParentCategoryId, IconUrl | Hierarchical Lookup | Supports nested categories: Towing → Hitches, Towing → Wiring, Exterior → Running Boards, etc. |
| **Products** | Id, SKU, Name, CategoryId, Price, Description, ImageUrl, Brand, WeightLbs | Core Entity | FK to Categories. Brand included for filtering. Spans all verticals. |
| **FitmentMappings** | Id, VehicleId, ProductId, FitmentNotes, IsVerified, InstallDifficulty | Junction (M:N) | **THE KEY TABLE.** Links vehicles to compatible products. FitmentNotes stores install specifics. InstallDifficulty (1–5) enables filtering. |
| **Orders** | Id, CustomerId, OrderDate, Total | Transactional | Simulated order history used to train the recommendation model. |
| **OrderItems** | Id, OrderId, ProductId, Quantity, Price | Transactional | Line items. Co-occurrence patterns here feed ML.NET training data. |

#### 4.1.2 Stored Procedures

Create stored procedures for the performance-critical fitment lookup queries. These will be called via Dapper for maximum speed. Key procedures:

- **`sp_GetCompatibleProducts(@VehicleId, @CategoryId)`** — Returns all products compatible with a specific vehicle, optionally filtered by category. Joined with product details and sorted by category.
- **`sp_GetVehicleCascade(@MakeId, @ModelId)`** — Powers the year → make → model dropdown cascade.
- **`sp_GetProductCoOccurrence(@ProductId, @TopN)`** — Returns the top N products most frequently purchased alongside a given product. Used as a fallback/validation for the ML model.
- **`sp_GetCategoryBreakdown(@VehicleId)`** — Returns a count of compatible products per category for a given vehicle. Powers the category filter tabs with accurate counts.

### 4.2 MongoDB Collections (Flexible Content)

MongoDB handles the semi-structured data that would be awkward in SQL Server. This demonstrates polyglot persistence — choosing the right database for the right data shape. This is especially important in a multi-category platform where product metadata varies wildly between a hitch and a headlight.

- **`product_reviews`** — `{ productId, rating, title, body, author, vehicleUsed, verifiedPurchase, helpfulVotes, createdAt }`. Embedding `vehicleUsed` lets you show "reviews from people with your vehicle."
- **`product_catalog_extended`** — `{ productId, specifications: {}, installGuides: [], compatibilityNotes: [], tags: [], fitmentDetails: {} }`. Flexible schema for varying product metadata. A hitch has receiver size and weight class; a headlight has bulb type and lumens; a running board has material and finish. This data shape is inherently document-oriented.

---

## 5. API Design

The API follows RESTful conventions with clear resource-oriented endpoints. Use API versioning from the start (`/api/v1/`) to demonstrate production readiness.

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/vehicles/makes` | List all makes |
| GET | `/api/v1/vehicles/makes/{makeId}/models` | List models for a make |
| GET | `/api/v1/vehicles/makes/{makeId}/models/{modelId}/years` | List years for a make/model combo |
| GET | `/api/v1/vehicles/{vehicleId}` | Get full vehicle details (tow capacity, body style, etc.) |
| GET | `/api/v1/vehicles/{vehicleId}/products?categoryId=&sort=&page=` | Get compatible products for a vehicle with filtering, sorting, pagination |
| GET | `/api/v1/vehicles/{vehicleId}/categories` | Get category breakdown with product counts for a vehicle |
| GET | `/api/v1/products/{productId}` | Get product details (SQL Server + MongoDB catalog data merged) |
| GET | `/api/v1/products/{productId}/reviews?vehicleId=&page=` | Get paginated reviews from MongoDB, optionally filtered by vehicle |
| GET | `/api/v1/products/{productId}/recommendations` | ML.NET-powered "Frequently Bought Together" predictions |
| GET | `/api/v1/products/{productId}/compatibility/{vehicleId}` | Boolean compatibility check with fitment notes and install difficulty |
| GET | `/api/v1/categories` | Get full category tree (hierarchical) |

All endpoints should return consistent JSON envelope responses: `{ success: true, data: {...}, meta: { page, totalPages, totalCount }, errors: [] }`. Implement global exception handling middleware and request/response logging.

---

## 6. Frontend Design (Angular)

### 6.1 Design Philosophy

The UI should feel like a real e-commerce product page, not a developer demo. Take visual inspiration from best-in-class automotive parts retailers — clean, functional, conversion-oriented. The design should communicate: "This person understands e-commerce UX and builds with the customer in mind." The multi-category nature of the catalog should feel natural, not bolted on.

### 6.2 Core Views & Components

#### 6.2.1 Vehicle Selector (Hero Component)

This is the most important UI element. It should be prominent, intuitive, and visually satisfying. Implementation details:

- Three cascading dropdowns: **Year → Make → Model**. Each selection triggers an API call to populate the next dropdown.
- Use Angular Reactive Forms with async validators. Debounce the cascade API calls.
- Add a vehicle silhouette or icon that updates dynamically based on the selected vehicle type (truck, SUV, sedan, car) for visual delight.
- Include a "Saved Vehicles" feature using in-memory state (or localStorage) so users can quickly switch between vehicles — a common pattern on real parts sites.
- After selection, show a vehicle summary card: tow capacity, body style, drive type. This immediately demonstrates the data depth.

#### 6.2.2 Category Navigation

After vehicle selection, display the available categories with product counts. This is a critical UX element that distinguishes FitSpec from a single-category app:

- Category cards or tabs: Towing, Exterior, Lighting, Interior, Performance. Each shows the count of compatible products for the selected vehicle.
- Clicking a category filters the product grid. "All" shows everything.
- Use icons for each category to provide visual scannability.

#### 6.2.3 Product Results Grid

Display compatible products in a filterable, sortable grid:

- Filter by: category, brand, price range, install difficulty, verified fit status.
- Sort by: price (low/high), rating, popularity, install difficulty.
- Each product card shows: product image, name, brand, price, star rating (from MongoDB reviews), compatibility confidence badge ("Verified Fit" / "Community Reported"), install difficulty indicator, and a quick "Add to Build" button.
- Implement Angular animations for smooth card transitions when filtering.

#### 6.2.4 Product Detail Page

Clicking a product card navigates to a detail view with:

- Full product information with category-specific specifications pulled from MongoDB (e.g., receiver size and weight class for hitches, lumens and bulb type for headlights).
- A "Frequently Bought Together" section powered by the ML.NET recommendation endpoint. Show 3–4 recommended products with "Add Bundle to Cart" pricing.
- Vehicle-filtered reviews: "Reviews from other [2022 Ford F-150] owners."
- Fitment notes and install difficulty specific to the selected vehicle.
- Cross-category suggestions: "People who bought this hitch also bought these wiring harnesses and running boards."

#### 6.2.5 Build Summary Sidebar

A persistent sidebar (or bottom drawer on mobile) that shows the user's running "build" — all selected products for their vehicle, organized by category. Show running total, compatibility status for each item, and an "Export Build List" button (generates a shareable summary). This mimics real e-commerce cart behavior and demonstrates product thinking.

### 6.3 Visual Design Standards

- Use **Angular Material** as the component library base, with custom theming to avoid a generic Material look.
- **Color palette:** Professional automotive/industrial feel. Navy or dark charcoal primary, a warm accent (amber or orange for CTAs), neutral grays for backgrounds. Green for "Verified Fit" badges.
- **Typography:** Clean sans-serif (Inter or Roboto). Clear hierarchy between headings, product names, prices, and body text.
- **Responsive:** Must look excellent on desktop and tablet. Mobile should be functional but desktop is the showcase.
- **Micro-interactions:** Subtle hover effects on product cards, smooth dropdown cascades, loading skeleton screens (not spinners).
- **Empty states:** Design thoughtful empty states ("Select a vehicle to find compatible parts") with illustrations or icons.

---

## 7. ML.NET Recommendation Engine

### 7.1 Approach: Matrix Factorization

Use ML.NET's Matrix Factorization trainer to build a collaborative filtering model. The model learns latent patterns in which products are purchased together, enabling "Frequently Bought Together" predictions. In a multi-category platform, this is especially powerful because it can surface cross-category recommendations (hitch → wiring harness → brake controller) that a simple "same category" filter would miss.

### 7.2 Training Pipeline

1. **Generate synthetic order data:** Create a data generator that produces realistic order histories. Key patterns to simulate across categories: hitches are almost always purchased with wiring harnesses; brake controllers co-occur with hitches on heavy-duty vehicles; running boards are frequently bought in pairs with mud flaps; headlight upgrades often pair with tail light upgrades; accessories (locks, covers, anti-rattle devices) are high-frequency add-ons.
2. **Build co-occurrence matrix:** Transform OrderItems into pairwise product co-occurrence records: `{ ProductA, ProductB, CoOccurrenceCount }`.
3. **Train the model:** Use ML.NET's `MatrixFactorizationTrainer` on the co-occurrence data. Tune hyperparameters (approximation rank, learning rate, iterations).
4. **Evaluate:** Split data 80/20 and measure RMSE. Document the evaluation metrics in the README.
5. **Serve predictions:** Wrap the trained model in a singleton `PredictionEngine<TInput, TOutput>` registered in the API's DI container. The `/recommendations` endpoint calls this service.

### 7.3 Prediction Service Interface

Define an `IRecommendationService` interface in Core with a method: `Task<List<ProductRecommendation>> GetRecommendations(int productId, int topN = 4)`. The implementation in `FitSpec.ML` loads the serialized `.zip` model and runs predictions. This clean separation allows swapping the ML implementation without touching the API layer.

---

## 8. Testing Strategy

Testing should demonstrate understanding of the testing pyramid: many unit tests, fewer integration tests, and targeted E2E tests for critical user journeys.

### 8.1 Unit Tests (xUnit)

- **Fitment matching logic:** Given a vehicle ID, verify the correct products are returned across categories and incompatible ones are excluded.
- **Category filtering:** Verify that category breakdown returns accurate counts and that cross-category queries work correctly.
- **Recommendation service:** Mock the ML.NET model and verify the service returns correctly formatted predictions.
- **API controller tests:** Verify correct HTTP status codes, response shapes, pagination metadata, and error handling.
- **Dapper repository tests:** Use an in-memory SQL Server (LocalDB or testcontainers) to verify stored procedure behavior.

### 8.2 Integration Tests

- API integration tests using `WebApplicationFactory<Program>` to test the full request pipeline.
- Database integration tests verifying the fitment cascade query returns accurate results across the full vehicle → category → product chain.
- MongoDB integration tests verifying that category-specific metadata retrieval works correctly.

### 8.3 E2E Tests (Playwright)

- **Critical path:** Select vehicle → Browse categories → Filter products → View product detail → See recommendations. This is the core user journey and must pass on every commit.
- **Vehicle cascade:** Verify that selecting a make populates models, and selecting a model populates years, with correct data at each step.
- **Cross-category navigation:** Select a vehicle, browse towing products, switch to exterior, verify correct products load for each category.
- **Compatibility validation:** Select a vehicle, navigate to a product, verify the compatibility badge and fitment notes match expected data.

---

## 9. Seed Data Strategy

Realistic seed data is critical to making this project feel like a real product. Poor seed data will make even a well-built app look like a toy. The multi-category approach requires more thoughtful seeding, but the payoff is a much more impressive demo.

### 9.1 Vehicle Data

Seed with 50–100 popular vehicles across years 2015–2025. Include a mix of vehicle types to demonstrate fitment variation:

- **Trucks:** Ford F-150, F-250, F-350; Chevrolet Silverado 1500/2500; RAM 1500/2500; Toyota Tacoma, Tundra; GMC Sierra; Nissan Titan
- **SUVs:** Jeep Wrangler, Grand Cherokee; Toyota 4Runner, Highlander; Honda Pilot; Ford Explorer, Bronco; Chevrolet Tahoe
- **Cars/Crossovers:** Honda CR-V, Civic; Toyota Camry, RAV4; Ford Escape; Hyundai Tucson; Subaru Outback

Include trim levels where relevant for fitment variation. Trucks and SUVs will have broader product compatibility; sedans will have fewer towing options but still match lighting and interior accessories.

### 9.2 Product Catalog

Seed with 120–180 products across categories. Use realistic product names and pricing based on actual aftermarket products.

- **Towing (40–50 products):** Class I–V receiver hitches ($80–$600), wiring harnesses in 4-pin/5-pin/7-pin ($20–$120), proportional and time-delayed brake controllers ($40–$250), ball mounts and hitch balls ($15–$80), hitch accessories (locks, covers, anti-rattle, $8–$30).
- **Exterior (30–40 products):** Running boards and nerf bars ($150–$500), mud flaps ($25–$80), fender flares ($80–$300), tonneau covers ($200–$600), bug deflectors ($30–$60).
- **Lighting (20–30 products):** LED headlight bulbs ($30–$120), tail light assemblies ($60–$200), fog lights ($40–$150), light bars ($80–$300), interior LED kits ($15–$40).
- **Cargo & Utility (20–30 products):** Roof racks and crossbars ($100–$350), cargo carriers ($60–$250), bike racks ($80–$300), truck bed organizers ($40–$150), roof baskets ($100–$250).

### 9.3 Simulated Orders

Generate 3,000–6,000 simulated orders with realistic purchasing patterns. The co-occurrence patterns should reflect real-world behavior:

- 85% of hitch purchases include a wiring harness (within-category)
- 60% of Class III+ hitch purchases include a brake controller (within-category)
- 40% of running board purchases include mud flaps (within-category)
- 70% of headlight upgrades include a matching tail light upgrade (within-category)
- 25% of hitch buyers also purchase running boards or cargo carriers (cross-category)
- Ball mounts appear in 70% of hitch orders
- Small accessories (locks, covers, anti-rattle devices) appear at a 30–40% attachment rate

These cross-category patterns are what make the ML.NET recommendations especially valuable — they surface connections a simple category filter would miss.

---

## 10. Implementation Phases

Build incrementally. Each phase produces a working, demonstrable slice of the application. Do not build the entire backend before starting the frontend.

| Phase | Deliverables | Key Milestones | Est. Effort |
|-------|-------------|----------------|-------------|
| **Phase 1: Foundation** | SQL Server schema + seed data (vehicles, categories, products), .NET Core API scaffold, Vehicle cascade endpoints + category tree endpoint, Angular project init with vehicle selector UI | User can select Year/Make/Model, see vehicle summary, and browse category cards with product counts | 3–4 days |
| **Phase 2: Core Fitment** | FitmentMapping table + stored procedures, Products endpoints with filtering/sorting/pagination, Product results grid with category tabs, Product detail page with category-specific specs | User can select a vehicle, browse categories, filter and sort products, and view detailed product pages | 4–5 days |
| **Phase 3: Intelligence** | MongoDB integration (reviews + extended catalog), ML.NET training pipeline with cross-category patterns, Recommendation endpoint, "Frequently Bought Together" UI with cross-category suggestions | Product pages show ML-powered recommendations (including cross-category) and vehicle-filtered reviews | 3–5 days |
| **Phase 4: Polish & Testing** | xUnit test suite, Playwright E2E tests, Build Summary sidebar, Responsive refinement, Loading states, error handling, empty states | Full test coverage on critical paths, polished UI with micro-interactions and thoughtful empty states | 2–3 days |
| **Phase 5: Deployment (Local)** | Docker Compose configuration, GitHub Actions CI/CD pipeline (build → test → report), README with architecture diagram and screenshots | One-command local setup. Automated build/test pipeline. Portfolio-ready README. | 1–2 days |
| **Phase 5b: Azure Deployment** | Azure resource provisioning (App Service, Static Web Apps, Azure SQL, MongoDB Atlas), environment-specific config with Azure App Configuration, GitHub Actions deploy workflow targeting Azure, custom domain setup (optional) | Live demo URL. Full CI/CD pipeline from push to production. Azure experience on resume. | 2–3 days |

**Total Estimated Effort:** 15–22 days of focused work.

---

## 11. Deployment & DevOps

### 11.1 Local Development (Docker Compose)

Provide a `docker-compose.yml` that spins up the entire stack: SQL Server container (with seed data auto-applied), MongoDB container, .NET API container, Angular dev server. A developer (or interviewer) should be able to clone the repo and run a single command to see the full application.

### 11.2 Azure Cloud Deployment

The production deployment targets Azure's free and low-cost tiers. This keeps the demo live at zero cost while putting real Azure experience on the resume. The architecture maps to how .NET applications are actually deployed in enterprise environments.

#### 11.2.1 Azure Services & Tiers

| Service | Azure Resource | Tier | Purpose | Cost |
|---------|---------------|------|---------|------|
| .NET API | Azure App Service | **B1 (Basic) — Recommended** | Hosts the ASP.NET Core Web API. Always-on, custom domain SSL, no cold starts, no compute caps. | ~$13/mo |
| Angular SPA | Azure Static Web Apps | Free | Hosts the built Angular app as static files with global CDN. Includes free SSL and custom domain support. | $0 |
| SQL Server | Azure SQL Database | Free tier | 32GB storage, 100K vCore seconds/month. More than enough for seed data and demo traffic. | $0 |
| MongoDB | MongoDB Atlas | M0 (Free) | 512MB storage, shared cluster. Hosts reviews and extended catalog. Not an Azure service, but integrates seamlessly. | $0 |
| Secrets | Azure Key Vault | Free tier | Stores connection strings and API keys. 10K operations/month free. | $0 |
| Config | Azure App Configuration | Free tier | Environment-specific configuration (dev vs. prod connection strings, feature flags). | $0 |

**Total monthly cost: ~$13/mo**

> **Why B1 over Free (F1)?** The F1 tier has cold starts of 15–20 seconds after inactivity, a 60 min/day compute cap, and no custom domain SSL. In a live interview demo, a 20-second loading screen kills the impression. B1 is always-on, loads instantly, and supports custom domains with managed SSL. The $13/mo pays for itself the first time an interviewer clicks your link and it just works.

> **Shared App Service Plan:** The B1 plan supports up to 3 apps. This means FitSpec doesn't have to be the only project on it — you can deploy other .NET portfolio projects (e.g., ReadmitRisk API, a future Azure Functions project, a Blazor experiment) on the same plan at no additional cost. Think of it as your Azure portfolio infrastructure, not a single-project expense.

> **Fallback:** If you need to cut costs, you can scale down to F1 (Free) at any time with a single CLI command (`az appservice plan update --sku F1`). The app keeps running, just with the cold-start and compute limitations.

#### 11.2.2 Resource Setup Steps

1. **Create an Azure account** (free, includes $200 credit for 30 days — but the free tiers persist beyond the trial).
2. **Create a Resource Group** named `fitspec-rg` in Central US (closest to St. Louis) to contain all resources.
3. **Provision Azure SQL Database:**
   - Create a logical SQL Server (`fitspec-sql-server`)
   - Create a database (`fitspec-db`) on the free tier
   - Configure firewall rules: allow Azure services + your IP for local development
   - Run the schema migration and seed scripts against the Azure SQL instance
4. **Provision Azure App Service:**
   - Create an App Service Plan on the F1 (Free) tier
   - Create a Web App (`fitspec-api`) targeting .NET 8
   - Configure application settings with connection strings (point to Azure SQL + MongoDB Atlas)
   - Enable Application Insights (free tier) for basic monitoring and request logging
5. **Provision Azure Static Web Apps:**
   - Create a Static Web App linked to your GitHub repo
   - Configure the build: app location = `/src/fitspec-ui`, output location = `dist/fitspec-ui`
   - The Angular SPA auto-deploys on every push to main
6. **Set up MongoDB Atlas:**
   - Create an M0 free cluster
   - Whitelist Azure App Service outbound IPs (or allow 0.0.0.0/0 for demo simplicity)
   - Create database user and connection string
   - Run MongoDB seed scripts to populate reviews and extended catalog
7. **Configure Azure Key Vault:**
   - Store SQL connection string, MongoDB connection string, and any API keys
   - Grant the App Service managed identity access to Key Vault
   - Reference Key Vault secrets in App Service configuration using `@Microsoft.KeyVault(...)` syntax

#### 11.2.3 Environment Configuration Strategy

Use Azure App Configuration + environment variables to manage the dev/prod split cleanly:

- **Local development:** `appsettings.Development.json` points to Docker Compose containers (localhost SQL Server + MongoDB)
- **Azure production:** App Service configuration overrides point to Azure SQL + MongoDB Atlas via Key Vault references
- **No secrets in code, ever.** Connection strings live in Key Vault, referenced by App Service configuration. This is a production best practice worth demonstrating.

#### 11.2.4 Custom Domain (Optional but Impressive)

If you own a domain (e.g., through natedev.io), you can point a subdomain like `fitspec.natedev.io` to the Azure Static Web App and `api.fitspec.natedev.io` to the App Service. Both support free SSL via Azure-managed certificates. A custom domain transforms the project from "student demo" to "product."

### 11.3 CI/CD Pipeline (GitHub Actions → Azure)

Configure two GitHub Actions workflows:

**Workflow 1: Build & Test (runs on every push)**
1. Restore dependencies and build both .NET and Angular projects.
2. Run xUnit tests. Fail the build on any test failure.
3. Run Playwright E2E tests against a containerized environment.

**Workflow 2: Deploy to Azure (runs on push to main, after tests pass)**
1. Build the .NET API and publish artifacts.
2. Deploy to Azure App Service using the `azure/webapps-deploy` GitHub Action.
3. Angular SPA deploys automatically via Azure Static Web Apps' built-in GitHub integration.
4. Run a post-deployment health check: hit the `/api/v1/vehicles/makes` endpoint and verify a 200 response.

**Setup:** Store Azure publish profile as a GitHub Actions secret (`AZURE_WEBAPP_PUBLISH_PROFILE`). For the Static Web App, the deployment token is auto-configured when you link the GitHub repo during provisioning.

### 11.4 README as a Sales Document

The README should function as a portfolio piece, not just setup instructions. Include:

- A compelling project description that frames the business problem — not "I built a parts finder" but "I built a platform that solves the automotive aftermarket's core conversion problem: getting the right part on the right vehicle, every time"
- A **live demo link** prominently displayed (the Azure deployment URL or custom domain)
- An architecture diagram (Mermaid or image) showing both the application architecture and the Azure deployment topology
- A screenshot gallery of the UI showing multiple categories and the recommendation engine
- A clear "Quick Start" section for running locally via Docker Compose
- A tech stack table with justifications
- A section on design decisions and tradeoffs (especially the polyglot persistence choice and Dapper vs EF Core)
- Links to test coverage reports
- A deployment section explaining the Azure infrastructure choices

---

## 12. Interview Talking Points

This project is designed to generate specific, compelling talking points that adapt depending on the company you're interviewing with.

| Topic | Talking Point |
|-------|--------------|
| **Product Thinking** | "I built this because I spent 12 years in e-commerce and I know that fitment accuracy is the difference between a conversion and a return. Every architectural decision maps to a customer outcome." |
| **Multi-Category Architecture** | "The platform isn't locked to one product vertical. The same fitment schema handles towing, exterior, lighting, and cargo — which is exactly how a real parts retailer's catalog works. Adding a new category requires zero schema changes." |
| **Polyglot Persistence** | "I intentionally used both SQL Server and MongoDB because different data has different shapes. Fitment data is deeply relational — you need referential integrity. But a hitch and a headlight have completely different spec sheets, and that variability is naturally document-oriented." |
| **ML / Recommendations** | "The recommendation engine isn't just a cool feature — it directly targets AOV. The cross-category predictions are especially valuable: when the model surfaces 'people who bought this hitch also bought running boards,' that's revenue a category filter would never find." |
| **Testing Strategy** | "I used the testing pyramid: xUnit for fast unit tests on business logic, integration tests for the API pipeline, and Playwright for the critical customer journey. Tests run in CI on every push." |
| **Dapper vs EF Core** | "I used both intentionally. Dapper for the perf-critical fitment queries via stored procedures — those need to be fast because they're the core UX. EF Core for migrations and simpler CRUD where developer velocity matters more than raw query speed." |
| **Azure Deployment** | "It's not just a local demo — it's deployed on Azure App Service with Azure SQL, fronted by Azure Static Web Apps, with secrets in Key Vault. The CI/CD pipeline runs tests on every push and auto-deploys to production on merge to main. I wanted to show I can ship, not just build." |
| **Domain Expertise** | "This isn't a generic CRUD app. The fitment data model reflects how aftermarket automotive parts actually work — year/make/model/trim specificity, receiver classes, bulb types, mounting points. I built it to understand the domain, not just the stack." |
| **Adaptability** | "The architecture generalizes beyond automotive. The year/make/model pattern is really just a hierarchical compatibility lookup — the same pattern applies to electronics accessories, appliance parts, industrial equipment. The domain model is a template." |

---

## 13. Target Company Positioning

The same project tells a different story depending on the company. Here's how to frame it:

| Company / Type | Angle |
|----------------|-------|
| **etrailer** | "I seeded it with towing accessories because I know that's your core domain, but the architecture supports any fitment vertical. I built what your engineering team works on every day." |
| **AutoZone / O'Reilly / Advance Auto** | "The multi-category fitment model mirrors your core business — thousands of SKUs across dozens of categories, all keyed to year/make/model. The ML recommendations target AOV lift across categories." |
| **RealTruck / AmericanTrucks** | "The exterior and towing categories align with your catalog. The build summary feature mimics the 'build your truck' experience your customers expect." |
| **General E-Commerce** | "The fitment engine is a specialized compatibility system — the same pattern applies anywhere you need to match products to customer-specific configurations. The full Azure deployment with CI/CD shows I can ship production infrastructure, not just write code." |

---

## 14. Acceptance Criteria

The project is considered complete when all of the following criteria are met:

- [ ] A user can select a vehicle via Year → Make → Model cascading dropdowns and see a vehicle summary card.
- [ ] Category navigation shows available categories with accurate product counts for the selected vehicle.
- [ ] Product results can be filtered by category, brand, price, and install difficulty, and sorted by price/rating/popularity.
- [ ] Product detail pages show category-specific specifications from MongoDB.
- [ ] Product detail pages show ML.NET-powered "Frequently Bought Together" recommendations, including cross-category suggestions.
- [ ] Product reviews are sourced from MongoDB and can be filtered by the selected vehicle.
- [ ] The Build Summary tracks selected products organized by category with a running total.
- [ ] xUnit tests cover fitment matching logic, category filtering, recommendation service, and API controllers.
- [ ] At least 3 Playwright E2E tests cover the critical user journeys (vehicle selection → category browse → product detail → recommendation).
- [ ] The application runs via a single `docker-compose up` command.
- [ ] The application is live on Azure with a working demo URL (App Service + Static Web Apps + Azure SQL + MongoDB Atlas).
- [ ] Connection strings and secrets are stored in Azure Key Vault, not in code or config files.
- [ ] GitHub Actions pipeline builds, tests, and auto-deploys to Azure on every push to main.
- [ ] The UI is visually polished, responsive, and uses Angular Material with custom theming.
- [ ] README includes architecture diagram, screenshots across multiple categories, quick start guide, and design decisions.
- [ ] Seed data spans at least 4 product categories with realistic fitment mappings and co-occurrence patterns.

---

*End of Document*
