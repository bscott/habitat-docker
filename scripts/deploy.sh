#!/usr/bin/env sh
set -eu
if [ -n "${DEBUG:-}" ]; then set -x; fi

banner() { echo " ---> $*"; }
info() { echo "      $*"; }

if [ -z "${HAB_VERSION:-}" ]; then
  >&2 echo "Required environment variable: HAB_VERSION"
  exit 2
fi

if [ -z "${DOCKER_USERNAME:-}" ]; then
  >&2 echo "Required environment variable: DOCKER_USERNAME"
  exit 2
fi

if [ -z "${DOCKER_PASSWORD:-}" ]; then
  >&2 echo "Required environment variable: DOCKER_PASSWORD"
  exit 2
fi

image="bscott/habitat"
tag1="$(echo "$HAB_VERSION" | tr '/' '-')"
tag2="$(echo "$HAB_VERSION" | cut -d '/' -f 1)"
tag3="latest"

banner "Logging in to Docker Hub..."
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
info "Login success."

banner "Pushing $image:$tag1"
docker push "$image:$tag1"
info "Pushing $image:$tag1 complete."
banner "Pushing $image:$tag2"
docker push "$image:$tag2"
info "Pushing $image:$tag2 complete."
banner "Pushing $image:$tag3"
docker push "$image:$tag3"
info "Pushing $image:$tag3 complete."

info "Cleaning up"
rm -rf "$HOME/.docker/config.json"

banner "Deploy $image complete."

exit 0
