# Start with the Alpine base image
FROM alpine:latest

# Install necessary packages
RUN apk add --no-cache bash curl openjdk11-jdk git openssl python3 py3-pip aws-cli

# Set SBT version
ENV SBT_VERSION=1.8.2

# Install SBT
RUN curl -L -o sbt.zip https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.zip \
    && unzip sbt.zip -d /usr/local \
    && rm sbt.zip \
    && ln -s /usr/local/sbt/bin/sbt /usr/local/bin/sbt

# Verify installations
RUN mkdir -p /tmp/sbt-project && cd /tmp/sbt-project && sbt sbtVersion && rm -rf /tmp/sbt-project

# Run SBT (default command, can be overridden)
CMD ["aws" "--version"]
