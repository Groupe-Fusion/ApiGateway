# Étape de build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Copier tout le code dans le conteneur
COPY . .

# Restaurer les dépendances
RUN dotnet restore ApiGateway.csproj

# Publier l'application
RUN dotnet publish ApiGateway.csproj -c Release -o /out --no-restore

# Étape finale pour exécuter
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /out ./
ENTRYPOINT ["dotnet", "ApiGateway.dll"]
