# Usa la imagen base oficial de .NET Core
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

# Copia todos los archivos publicados
COPY . .

# Establece el punto de entrada de la aplicación
ENTRYPOINT ["dotnet", "SaveTheAir.dll"]

