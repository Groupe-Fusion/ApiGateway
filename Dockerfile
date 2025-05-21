# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /ApiGateway

# Copy the entire solution directory into the container (including all the projects)
COPY . .

RUN dotnet restore
RUN dotnet publish *.csproj -c release -o /app --no-restore

# run the app
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "ApiGateway.dll"]
