#!/usr/bin/env sh
set -eu
if [ -n "${DEBUG:-}" ]; then set -x; fi

banner() { echo " ---> $*"; }
info() { echo "      $*"; }

if [ -z "${HAB_VERSION:-}" ]; then
  >&2 echo "Required environment variable: HAB_VERSION"
  exit 2
fi

image="bscott/habitat"
tag="${image}:$(echo "$HAB_VERSION" | tr '/' '-')"

banner "Building $tag for hab version $HAB_VERSION"
docker build -t "$tag" --build-arg "HAB_VERSION=$HAB_VERSION" .
image_id="$(docker images -q "$tag")"
docker tag "$image_id" "${image}:latest"
info "Build complete."

info
banner "Docker image built: $tag ($image_id)"
info
info "Try it out with:"
info
info "    docker run --rm -ti --privileged -v \$(pwd):/src bscott/habitat sh"
info

exit 0
