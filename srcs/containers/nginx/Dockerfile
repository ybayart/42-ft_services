FROM alpine:latest
MAINTAINER ybayart
RUN apk update && apk add --no-cache nginx php-fpm openrc php7-pdo_mysql openssh
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key
RUN adduser -D ybayart
COPY srcs/ssh /home/ybayart/.ssh
COPY srcs/certs /etc/nginx/certs
COPY srcs/start.sh /bin/start.sh
CMD sh /bin/start.sh && tail -F /dev/null

EXPOSE 22
EXPOSE 3306
