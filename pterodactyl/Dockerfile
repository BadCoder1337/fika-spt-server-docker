# Pterodactyl-compatible Docker image for SPT + Fika Server
# Based on official .NET 9 ASP.NET Core runtime with Pterodactyl user support

FROM mcr.microsoft.com/dotnet/aspnet:9.0-bookworm-slim

LABEL maintainer="BadCoder1337"
LABEL org.opencontainers.image.source="https://github.com/BadCoder1337/fika-spt-server-docker"
LABEL org.opencontainers.image.description="SPT + Fika Server for Pterodactyl Panel"
LABEL org.opencontainers.image.licenses="MIT"

# Install required packages for SPT server and Pterodactyl compatibility
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    unzip \
    p7zip-full \
    jq \
    locales \
    iproute2 \
    tini \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set locale for proper text handling
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Create Pterodactyl container user (UID 1000 is required by Pterodactyl)
RUN useradd -m -d /home/container -s /bin/bash -u 1000 container

# Set up working directory
WORKDIR /home/container

# Copy entrypoint script
COPY --chmod=755 entrypoint.sh /entrypoint.sh

# Switch to container user (Pterodactyl requirement)
USER container
ENV USER=container \
    HOME=/home/container

# Expose SPT server port
EXPOSE 6969

# Use tini as init system for proper signal handling
ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD ["/bin/bash", "/entrypoint.sh"]
