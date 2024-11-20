# Etapa base para construcción
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo de proyecto (.csproj) al contenedor
COPY ["SaveTheAir/SaveTheAir.csproj", "SaveTheAir/"]

# Restaura las dependencias
RUN dotnet restore "SaveTheAir/SaveTheAir.csproj"

# Copia el resto del código fuente al contenedor
COPY . .

# Construye el proyecto
RUN dotnet build "SaveTheAir/SaveTheAir.csproj" -c Release --no-restore -o /app/build

# Publica la aplicación
RUN dotnet publish "SaveTheAir/SaveTheAir.csproj" -c Release --no-build -o /app/publish

# Etapa base para ejecución (con .NET 8.0)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia la publicación desde la etapa de construcción
COPY --from=build /app/publish .

# Expone el puerto (ajusta si es necesario)
EXPOSE 80

# Comando de entrada para ejecutar la aplicación
ENTRYPOINT ["dotnet", "SaveTheAir.dll"]


