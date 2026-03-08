FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
EXPOSE 5062

FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["src/FitSpec.API/FitSpec.API.csproj", "src/FitSpec.API/"]
COPY ["src/FitSpec.Core/FitSpec.Core.csproj", "src/FitSpec.Core/"]
COPY ["src/FitSpec.Data/FitSpec.Data.csproj", "src/FitSpec.Data/"]
COPY ["src/FitSpec.ML/FitSpec.ML.csproj", "src/FitSpec.ML/"]
RUN dotnet restore "src/FitSpec.API/FitSpec.API.csproj"
COPY . .
WORKDIR "/src/src/FitSpec.API"
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENV ASPNETCORE_URLS=http://+:5062
ENTRYPOINT ["dotnet", "FitSpec.API.dll"]
