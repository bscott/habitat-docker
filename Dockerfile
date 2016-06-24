FROM alpine:3.3
MAINTAINER Brian L. Scott <Brian@Bscott.io>
RUN apk add --no-cache vim nano wget ca-certificates gnupg
RUN cd /tmp \
  && wget https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh \
  && sh install.sh \
  && rm -f install.sh \
  && echo "hab:x:42:42:root:/:/bin/sh" >> /etc/passwd \
  && echo "hab:x:42:hab" >> /etc/group
WORKDIR /src
VOLUME ["/src"]
CMD ["hab"]
