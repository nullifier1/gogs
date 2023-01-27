FROM alpine:latest
RUN echo http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.17/main/ > /etc/apk/repositories && \
    echo http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.17/community/ >> /etc/apk/repositories && \
    apk add git bash
COPY /custom/conf/app.ini /usr/local/bin/custom/conf/app.ini
COPY gogs /usr/local/bin
