# Use the official Microsoft .NET image as a base image
FROM mcr.microsoft.com/dotnet/sdk:8.0.5 AS build

# Set the working directory inside the container
WORKDIR /src

# Copy the .csproj file and restore any dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application code and build it
COPY . ./
RUN dotnet publish -c Release -o out

# Use the official Microsoft .NET runtime image as a base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0.5 AS runtime

# Set the working directory inside the container
WORKDIR /src

# Copy the build output to the runtime image
COPY --from=build /src .

# Specify the entry point for the application
ENTRYPOINT ["dotnet", "HelloWorld.Sample.dll"]