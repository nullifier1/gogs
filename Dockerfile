FROM alpine:latest
RUN apk --no-cache --no-progress add --virtual git
RUN mkdir -p /usr/local/bin/custom/conf
COPY gogs /usr/local/bin
COPY /custom/conf/app.ini /usr/local/bin/custom/conf
CMD ["sleep","3200"]
