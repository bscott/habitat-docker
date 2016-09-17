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
  && wget https://gist.githubusercontent.com/fnichol/55501687ecdcd0f7218f0416673ca896/raw/12594be4d572d4befdee0b22130619b9301c3d19/install.sh \
  && sh install.sh ${HAB_VERSION:-} \
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
