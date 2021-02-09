FROM mcr.microsoft.com/dotnet/sdk:5.0

LABEL MAINTAINER='flaviogf'

ENV OPENJDK_VERSION=11 \
    SONAR_SCANNER_VERSION=5.0.4

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y apt-transport-https ca-certificates wget gnupg-agent software-properties-common

RUN mkdir -p /usr/share/man/man1mkdir -p /usr/share/man/man1

RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - \
    && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
    && apt-get update \
    && apt-get install -y adoptopenjdk-$OPENJDK_VERSION-hotspot

RUN dotnet tool install --global dotnet-sonarscanner --version $SONAR_SCANNER_VERSION

ENV PATH="${PATH}:/root/.dotnet/tools"
