FROM alpine:latest
MAINTAINER ybayart
RUN apk update && apk add --no-cache influxdb
COPY srcs/start-influxdb.sh /bin/start-influxdb.sh
CMD sh /bin/start-influxdb.sh && tail -F /dev/null

EXPOSE 8086
