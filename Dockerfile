FROM ubuntu
WORKDIR /app
COPY gogs .
CMD ["sleep","3600"]
