FROM alpine:latest
MAINTAINER ybayart
RUN apk update && apk add --no-cache nginx php-fpm openrc php7-pdo_mysql
COPY srcs/certs /etc/nginx/certs
COPY srcs/start.sh /bin/start.sh
CMD sh /bin/start.sh && tail -F /dev/null

VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 3306
