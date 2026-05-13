FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build ٍٍٍِِِ

WORKDIR /src 

COPY *.csproj ./

RUN dotnet restore

COPY . .

RUN dotnet publish -c release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=build /app/publish .

USER appuser

ENTRYPOINT ["dotnet", "catalog.API.dll"]