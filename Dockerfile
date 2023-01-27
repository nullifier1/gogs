FROM golang:alpine
RUN echo http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.17/main/ > /etc/apk/repositories && \
    echo http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.17/community/ >> /etc/apk/repositories && \
    apk --no-cache --no-progress add --virtual \
     build-deps \
     build-base \
     git \
     linux-pam-dev \
     openssh \
     s6 \
     shadow \
     socat \
     tzdata \
     rsync \
     docker \
     sudo 
ENV GOCACHE /tmp/
VOLUME /var/run/docker.sock
