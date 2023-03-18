#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["Presentation.GRPC/Presentation.GRPC.csproj", "Presentation.GRPC/"]
RUN dotnet restore "Presentation.GRPC/Presentation.GRPC.csproj"
COPY . .
WORKDIR "/src/Presentation.GRPC"
RUN dotnet build "Presentation.GRPC.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Presentation.GRPC.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Presentation.GRPC.dll"]