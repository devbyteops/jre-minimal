## Repo for a docker light weight image that has jre modules installed
- We set a non-root user for our docker image.
- Pass `USER_NAME` to set the non-root username in yaml under `build-args` (default i am using appuser)
- Push image to dockerhub under same username `devbyteops/jre11-minimal`
- Support two architectures `amd64` & `arm64`
