FROM telegraf:v1
MAINTAINER ybayart
RUN apk update && apk add influxdb
RUN sed -i -e "s/TMPBDD/influxdb/g" /etc/telegraf/telegraf.conf
RUN sed -i -e "s/http:\/\/influxdb:/http:\/\/127.0.0.1:/g" /etc/telegraf/telegraf.conf
COPY srcs/start-influxdb.sh /bin/startscript/start-influxdb.sh
CMD sh /bin/startscript/start-influxdb.sh && tail -F /dev/null

EXPOSE 8086
