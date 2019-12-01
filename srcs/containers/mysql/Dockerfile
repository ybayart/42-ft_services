FROM telegraf:v1
MAINTAINER ybayart
RUN apk update && apk add mariadb mariadb-client mariadb-server-utils
RUN addgroup mysql mysql
RUN mkdir -p /etc/mysql/conf.d
RUN sed -i -e "s/TMPBDD/mysql/g" /etc/telegraf/telegraf.conf
COPY srcs/conf /etc/mysql
COPY srcs/start-mysql.sh /bin/startscript/start-mysql.sh
COPY srcs/wordpress.sql /bin/startscript/wordpress.sql
CMD sh /bin/startscript/start-mysql.sh && tail -F /dev/null

EXPOSE 3306
