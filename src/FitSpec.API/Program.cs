// FitSpec API — ASP.NET Core 10
using Asp.Versioning;
using FitSpec.Core.Interfaces;
using FitSpec.Data;
using FitSpec.Data.Repositories;
using FitSpec.ML;
using Dapper;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// EF Core
builder.Services.AddDbContext<FitSpecDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Dapper
builder.Services.AddSingleton<IDapperConnectionFactory, DapperConnectionFactory>();

// Repositories
builder.Services.AddScoped<IVehicleRepository, VehicleRepository>();
builder.Services.AddScoped<ICategoryRepository, CategoryRepository>();
builder.Services.AddScoped<IProductRepository, ProductRepository>();
builder.Services.AddScoped<ISearchRepository, SearchRepository>();
builder.Services.AddScoped<IAdminRepository, AdminRepository>();
builder.Services.AddScoped<ICommunityBuildRepository, CommunityBuildRepository>();
builder.Services.AddScoped<IInventoryRepository, InventoryRepository>();

// MongoDB
builder.Services.AddSingleton<MongoDbContext>();
builder.Services.AddScoped<IProductReviewRepository, ProductReviewRepository>();
builder.Services.AddScoped<IProductCatalogRepository, ProductCatalogRepository>();
builder.Services.AddScoped<IProductQARepository, ProductQARepository>();

// ML.NET Recommendations
builder.Services.AddSingleton<IRecommendationService>(sp =>
    new RecommendationService(
        sp.GetRequiredService<IProductRepository>(),
        Path.Combine(AppContext.BaseDirectory, "ml-model.zip")));

// SignalR
builder.Services.AddSignalR();

// HttpClient for Claude API
builder.Services.AddHttpClient();

// API Versioning
builder.Services.AddApiVersioning(options =>
{
    options.DefaultApiVersion = new ApiVersion(1, 0);
    options.AssumeDefaultVersionWhenUnspecified = true;
    options.ReportApiVersions = true;
    options.ApiVersionReader = new UrlSegmentApiVersionReader();
})
.AddApiExplorer(options =>
{
    options.GroupNameFormat = "'v'VVV";
    options.SubstituteApiVersionInUrl = true;
});

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new() { Title = "FitSpec API", Version = "v1" });
});

// CORS
var allowedOrigins = builder.Configuration.GetSection("AllowedOrigins").Get<string[]>()
    ?? new[] { "http://localhost:4200" };
builder.Services.AddCors(options =>
{
    options.AddPolicy("Angular", policy =>
    {
        policy.WithOrigins(allowedOrigins)
            .AllowAnyHeader()
            .AllowAnyMethod()
            .AllowCredentials();
    });
});

var app = builder.Build();

// Middleware
app.UseMiddleware<FitSpec.API.Middleware.ExceptionHandlingMiddleware>();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "FitSpec API v1"));
}

app.UseCors("Angular");

var lastDbPing = DateTime.MinValue;
app.MapGet("/health", async (IDapperConnectionFactory db) =>
{
    var now = DateTime.UtcNow;
    if ((now - lastDbPing).TotalMinutes >= 5)
    {
        using var conn = db.CreateConnection();
        await conn.ExecuteScalarAsync<int>("SELECT 1");
        lastDbPing = now;
    }
    return Results.Ok(new { status = "healthy", timestamp = now });
});
app.MapControllers();
app.MapHub<FitSpec.API.Hubs.InventoryHub>("/hubs/inventory");

// Seed data on --seed flag
if (args.Contains("--seed"))
{
    using var scope = app.Services.CreateScope();
    var context = scope.ServiceProvider.GetRequiredService<FitSpecDbContext>();
    await context.Database.MigrateAsync();
    Console.WriteLine("Database migrated and ready for seeding.");
}

app.Run();

// Make Program class accessible for integration tests
public partial class Program { }
