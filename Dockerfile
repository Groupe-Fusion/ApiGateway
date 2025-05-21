# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /FusionAPI

# Copy the entire solution directory into the container (including all the projects)
COPY . .

RUN dotnet restore
RUN dotnet publish ApiGateway/*.csproj -c release -o /app --no-restore

# run the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "ApiGateway.dll"]
