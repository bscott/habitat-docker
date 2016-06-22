FROM alpine:3.3
MAINTAINER Brian L. Scott <Brian@Bscott.io>
RUN apk add --no-cache vim nano wget ca-certificates gnupg xz
WORKDIR /tmp
RUN wget https://gist.githubusercontent.com/bscott/c14ee24a3feafd2f5234af8950c8b420/raw/hab-install.sh && sh hab-install.sh && rm -f hab-install.sh
WORKDIR /src
VOLUME ["/src"]
CMD ["hab"]
