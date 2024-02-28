FROM alpine:3.19.1 as packager

ARG USER_NAME=$USER_NAME

# Install required minimal JRE packages for Java 11, 17, and 21
RUN apk add --no-cache openjdk11-jre openjdk17-jre openjdk21-jre && \
    export JAVA_HOME_11=$(dirname $(dirname $(readlink $(readlink $(which java))))) && \
    export JAVA_HOME_17=$(dirname $(dirname $(readlink $(readlink $(which java))))) && \
    export JAVA_HOME_21=$(dirname $(dirname $(readlink $(readlink $(which java))))) && \
    export PATH=$JAVA_HOME_11/bin:$JAVA_HOME_17/bin:$JAVA_HOME_21/bin:$PATH

# Create a non-root user
RUN adduser -D $USER_NAME

# Set the default user
USER $USER_NAME

# Print installed Java versions
RUN java -version && \
    javac -version

# Set the default Java version
ENV JAVA_HOME $JAVA_HOME_21

# Command to run when the container starts
CMD ["java", "-version"]