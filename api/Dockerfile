# syntax=docker/dockerfile:1

# https://github.com/dotnet/dotnet-docker/blob/main/samples/README.md

FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS builder

# copy in git files for versioning
COPY . /source/

WORKDIR /source

# This is the architecture you’re building for, which is passed in by the builder.
# Placing it here allows the previous steps to be cached across architectures.
ARG TARGETARCH

# TODO pass as arg/env var to here?
ENV MY_APP_VERSION=v1.0.6

# Build the application.
# Leverage a cache mount to /root/.nuget/packages so that subsequent builds don't have to re-download packages.
# If TARGETARCH is "amd64", replace it with "x64" - "x64" is .NET's canonical name for this and "amd64" doesn't
#   work in .NET 6.0.
RUN --mount=type=cache,id=nuget,target=/root/.nuget/packages \
    dotnet publish -a ${TARGETARCH/amd64/x64} --use-current-runtime --self-contained false -o /app \
    -p:MY_APP_VERSION=${MY_APP_VERSION}


FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS runner
WORKDIR /app

COPY --from=builder /app .

# 8.x+ port 8080=>80 https://learn.microsoft.com/en-us/dotnet/core/compatibility/containers/8.0/aspnet-port
ENV ASPNETCORE_HTTP_PORTS=80

ENTRYPOINT ["dotnet", "api.dll"]


# FYI azure docker logs (not container logs):
# INFO - docker run -d --expose=80 --name weshigbee_0... -e WEBSITE_USE_DIAGNOSTIC_SERVER=false -e WEBSITES_ENABLE_APP_SERVICE_STORAGE=false -e WEBSITE_SITE_NAME=weshigbee -e WEBSITE_AUTH_ENABLED=False -e PORT=80 -e WEBSITE_ROLE_INSTANCE_ID=0 -e WEBSITE_HOSTNAME=weshigbee.azurewebsites.net -e WEBSITE_INSTANCE_ID=... index.docker.io/weshigbee/actions-web-test
# INFO - Logging is not enabled for this container.
# Please use https://aka.ms/linux-diagnostics to enable logging to see container logs here.