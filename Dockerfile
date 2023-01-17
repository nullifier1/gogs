FROM alpine:latest
RUN echo http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.17/main/ > /etc/apk/repositories; \
    echo http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.17/community/ >> /etc/apk/repositories>
    apk add --no-cache \
        git
RUN mkdir -p /usr/local/bin/custom/conf
COPY gogs /usr/local/bin
COPY /custom/conf/app.ini /usr/local/bin/custom/conf
CMD ["gogs","web"]
