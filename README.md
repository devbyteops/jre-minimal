## Repo for a docker light weight image that has jre modules installed
- Installed Java 11 with non-root user.
- Pass `USER_NAME` to set the non-root username in yaml under `build-args` (default user is `appuser`)
- Image available on dockerhub under same username [`devbyteops/jre-minimal`](https://hub.docker.com/r/devbyteops/jre-minimal)
- Support two architectures `amd64` & `arm64`
