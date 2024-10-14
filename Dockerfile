FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

RUN dotnet restore "ApiTeste.csproj"
COPY . .
WORKDIR "/src"
RUN dotnet build "ApiTeste.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ApiTeste.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ApiTeste.dll"]
