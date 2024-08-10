## Light weight docker image with minimal jre modules installed
- Installed Java 11 with non-root user, default user == `appuser`.
- Pass `USER_NAME` to set the non-root username in yaml under `build-args`.
- Image available on dockerhub under same username [`devbyteops/jre-minimal`](https://hub.docker.com/r/devbyteops/jre-minimal).
- Support two architectures `amd64` & `arm64`.
