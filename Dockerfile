FROM alpine:latest as packager

RUN apk --no-cache add openjdk11-jdk openjdk11-jmods

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
FROM alpine:3.20.2
ENV JAVA_MINIMAL=/opt/jre
ENV PATH="$PATH:$JAVA_MINIMAL/bin"
COPY --from=packager "$JAVA_MINIMAL" "$JAVA_MINIMAL"
# Create the app user & Configure working directory
ARG USER_NAME
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN apk update && apk --no-cache add bash \
    && addgroup --gid $USER_GID $USER_NAME \
    && adduser -D -S -G $USER_NAME -u $USER_UID $USER_NAME --shell /bin/bash \
    && mkdir /home/$USER_NAME/app && chown -R $USER_UID:$USER_GID /home/$USER_NAME/app && chmod -R 755 /home/$USER_NAME/app
USER $USER_NAME