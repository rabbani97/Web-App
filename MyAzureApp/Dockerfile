# Use the official ASP.NET runtime as base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Copy the application files
COPY . .

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["dotnet", "MyAzureApp.dll"]
