# Start with the Alpine base image
FROM alpine:latest

# Install necessary packages
RUN apk add --no-cache \
    bash \
    curl \
    openjdk11-jdk \
    git \
    openssl \
    py3-pip \
    && pip3 install --upgrade pip

# Set SBT version
ENV SBT_VERSION=1.8.2

# Install SBT
RUN curl -L -o sbt.zip https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.zip \
    && unzip sbt.zip -d /usr/local \
    && rm sbt.zip \
    && ln -s /usr/local/sbt/bin/sbt /usr/local/bin/sbt

# Install AWS CLI
RUN pip3 install awscli

# Verify installations
RUN sbt sbtVersion && aws --version

# Run SBT (default command, can be overridden)
CMD ["sbt"]
