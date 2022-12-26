FROM alpine:3.14
WORKDIR /app
COPY gogs .
CMD ["sleep","3600"]
