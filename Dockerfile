FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build

WORKDIR /src

COPY Catalog.API/*.csproj ./Catalog.API/
WORKDIR /src/Catalog.API

RUN dotnet restore

COPY Catalog.API/. .

RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=build /app/publish .

USER appuser

ENTRYPOINT ["dotnet", "Catalog.API.dll"]
