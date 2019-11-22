FROM nginx:v1
MAINTAINER ybayart
RUN apk add --no-cache wget
RUN cd /tmp/ \
&& wget https://fr.wordpress.org/wordpress-5.3-fr_FR.tar.gz \
&& tar xvf wordpress-5.3-fr_FR.tar.gz \
&& mv wordpress /var/www/wordpress \
&& rm -rf /tmp/*
COPY srcs/default /etc/nginx/conf.d/default.conf
