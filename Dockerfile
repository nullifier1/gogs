FROM golang:alpine3.14
RUN echo http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.17/main/ > /etc/apk/repositories && \
    usermod -d /home/jenkins jenkins && \
    echo http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.17/community/ >> /etc/apk/repositories && \
    apk --no-cache --no-progress add --virtual \
     build-deps \
     build-base \
     git \
     linux-pam-dev
ENV GOCACHE /tmp/
