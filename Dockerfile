FROM ubuntu
WORKDIR /app
COPY gogs .
WORKDIR /app/custom/conf/
COPY custom/conf/app.ini .
CMD ["sleep","320"]
