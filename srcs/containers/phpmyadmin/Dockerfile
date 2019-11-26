FROM nginx:v1
MAINTAINER ybayart
RUN apk add wget php7-iconv php7-json php7-session php7-mysqli
RUN cd /tmp/ \
&& wget https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-all-languages.tar.gz \
&& tar xvf phpMyAdmin-4.9.1-all-languages.tar.gz \
&& mv phpMyAdmin-4.9.1-all-languages /var/www/phpmyadmin \
&& chmod -R 777 /var/www \
&& rm -rf /tmp/*
RUN sed -i -e "s/\"nginx\"/\"phpmyadmin\"/g" /etc/telegraf/telegraf.conf
COPY srcs/config.inc.php /var/www/phpmyadmin
COPY srcs/default /etc/nginx/conf.d/default.conf
