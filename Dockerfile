FROM alpine:3.4
MAINTAINER Brian L. Scott <Brian@Bscott.io>
ARG HAB_VERSION=
RUN set -ex \
  && apk add --no-cache --virtual .build-deps \
    wget \
    ca-certificates \
    gnupg \
  \
  && cd /tmp \
  && wget https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh \
  && sh install.sh -v ${HAB_VERSION:-} \
  && rm -f install.sh \
  && apk del .build-deps \
  \
  && apk add --no-cache ncurses-terminfo-base \
  \
  && echo "hab:x:42:42:root:/:/bin/sh" >> /etc/passwd \
  && echo "hab:x:42:hab" >> /etc/group
WORKDIR /src
VOLUME ["/src"]
CMD ["/bin/hab"]
