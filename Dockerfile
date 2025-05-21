# Étape de build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copier tout le code dans le conteneur
COPY . .

# Restaurer les dépendances
RUN dotnet restore ApiGateway/ApiGateway.csproj

# Publier l'application
RUN dotnet publish ApiGateway/ApiGateway.csproj -c Release -o /app --no-restore

# Étape finale pour exécuter
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "ApiGateway.dll"]
