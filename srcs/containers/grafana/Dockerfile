FROM telegraf:v1
MAINTAINER ybayart
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk add grafana@testing
RUN sed -i -e "s/TMPBDD/grafana/g" /etc/telegraf/telegraf.conf
COPY srcs/start-grafana.sh /bin/startscript/start-grafana.sh
COPY srcs/grafana.db /usr/share/grafana/data/grafana.db
CMD sh /bin/startscript/start-grafana.sh && tail -F /dev/null
