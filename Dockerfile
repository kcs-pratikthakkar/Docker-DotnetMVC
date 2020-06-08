FROM microsoft/dotnet-framework:4.7.2-sdk AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY /CICD/CICD.csproj ./aspnetapp/
COPY /CICD/Web.config ./aspnetapp/
RUN nuget restore

# copy everything else and build app
COPY . ./aspnetapp/
WORKDIR /app/aspnetapp
RUN msbuild /t:rebuild /p:Configuration=Release /p:DeployOnBuild=True


# copy build artifacts into runtime image
FROM microsoft/aspnet:4.7.2 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build /app/aspnetapp/. ./
