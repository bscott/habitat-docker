# Habitat Docker Image

The [Habitat][] Docker image is a very minimal image which is based on the stock [Alpine Linux][] container and has `core/hab` installed with a binlink to `/bin/hab`. There are no other packages or software installed, so this could be used as a base to build higher order images. Alternatively, it is a perfect "clean room" for running Habitat Supervsirs, Studio builds, or anything else that Habitat can do.

## Examples

The default command is `/bin/hab` which will display the help usage:

```sh
> docker run -ti bscott/habitat
```

To get a login shell, just add `sh` (which comes from the Alpine Linux base):

```sh
> docker run -ti bscott/habitat sh
```

Don't forget, you can use Docker's `--rm` flag to remove the container once quit to save on removing tons of stopped containers later:

```sh
> docker run --rm -ti bscott/habitat sh
```

Remember that `hab` is on path, so this means you can start any Habitat package with the Supervisor that is published to the Builder depot:

```sh
> docker run --rm -ti bscott/habitat hab start core/redis
```

If you want to run Studio builds, then you need to provide the `--privileged` flag to `docker run`. If you'd like to mount your current working directory into the Docker image for building, you can also use the `-v` (`--volume`) option:

```sh
> docker run --rm -ti --privileged -v $(pwd):/src bscott/habitat sh
```

Or directly enter a Studio by calling it directly:

```sh
> docker run --rm -ti --privileged -v $(pwd):/src bscott/habitat hab studio enter
```

New version tags of this image are pushed with each Habitat release, so you can run a particular version with:

```sh
> docker run -ti bscott/habitat:0.34.1 hab --version
```

[Habitat]: https://www.habitat.sh
[Alpine Linux]: https://hub.docker.com/_/alpine/
