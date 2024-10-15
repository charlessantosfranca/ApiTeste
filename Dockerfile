FROM mcr.microsoft.com/dotnet/sdk:8.0 as build-env
WORKDIR /
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 as runtime
WORKDIR /publish
COPY --from=build-env /publish .
ENV ASPNETCORE_URLS=http://+:6000
EXPOSE 6000
ENTRYPOINT ["dotnet", "ApiTeste.dll"]
