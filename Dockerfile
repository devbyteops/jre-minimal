FROM alpine:3.19.1 as packager

RUN apk --no-cache add openjdk11-jdk openjdk11-jmods binutils

ENV JAVA_MINIMAL=/opt/jre

# build minimal JRE
RUN /usr/lib/jvm/java-11-openjdk/bin/jlink \
    --verbose \
    --add-modules \
        java.base,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument,jdk.crypto.ec,jdk.zipfs,jdk.unsupported \
    --compress 2 --strip-debug --no-header-files --no-man-pages \
    --release-info="add:IMPLEMENTOR=radistao:IMPLEMENTOR_VERSION=radistao_JRE" \
    --output "$JAVA_MINIMAL"

# Second stage, add only our minimal "JRE" distr and our app
FROM alpine:3.19.1
ENV JAVA_MINIMAL=/opt/jre
ENV PATH="$PATH:$JAVA_MINIMAL/bin"
COPY --from=packager "$JAVA_MINIMAL" "$JAVA_MINIMAL"
# Create the app user
ARG USER_NAME=app_user
ARG USER_GROUP=$USER_NAME
RUN apk update && apk upgrade && apk add --no-cache bash \
    && addgroup -S $USER_GROUP && adduser -S -G $USER_GROUP $USER_NAME --shell /bin/bash
USER $USER_NAME