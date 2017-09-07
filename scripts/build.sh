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
tag1="$(echo "$HAB_VERSION" | tr '/' '-')"
tag2="$(echo "$HAB_VERSION" | cut -d '/' -f 1)"
tag3="latest"

banner "Building $image for hab version $HAB_VERSION"
docker build \
  --tag "$image:$tag1" \
  --tag "$image:$tag2" \
  --tag "$image:$tag3" \
  --build-arg "HAB_VERSION=$HAB_VERSION" \
  .
image_id="$(docker images -q "$tag1")"
info "Build complete."

info
banner "Docker image built: $image ($image_id)"
info
info "Try it out with:"
info
info "    docker run --rm -ti --privileged -v \$(pwd):/src $image sh"
info

exit 0
