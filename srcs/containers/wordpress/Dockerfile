FROM nginx:v1
MAINTAINER ybayart
RUN apk add wget \
    libmcrypt-dev zlib-dev gmp-dev \
    freetype-dev libjpeg-turbo-dev libpng-dev \
    php7-json php7-zlib php7-xml php7-pdo php7-phar php7-openssl \
    php7-pdo_mysql php7-mysqli php7-session \
    php7-gd php7-iconv php7-mcrypt php7-gmp php7-zip \
    php7-curl php7-opcache php7-ctype php7-apcu \
    php7-intl php7-bcmath php7-dom php7-mbstring php7-xmlreader mysql-client
RUN cd /tmp/ \
&& wget https://fr.wordpress.org/wordpress-5.3-fr_FR.tar.gz \
&& tar xvf wordpress-5.3-fr_FR.tar.gz \
&& mv wordpress /var/www/wordpress \
&& chmod -R 777 /var/www \
&& rm -rf /tmp/*
RUN sed -i -e "s/\"nginx\"/\"wordpress\"/g" /etc/telegraf/telegraf.conf
COPY srcs/default /etc/nginx/conf.d/default.conf
