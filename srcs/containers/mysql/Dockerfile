FROM alpine:latest
MAINTAINER ybayart
RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-server-utils
RUN addgroup mysql mysql
COPY srcs/conf /etc/mysql
COPY srcs/start-mysql.sh /bin/start-mysql.sh
CMD sh /bin/start-mysql.sh && tail -F /dev/null

EXPOSE 3306
