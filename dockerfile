FROM php:7.4-apache


RUN docker-php-ext-install mysqli


CMD /usr/sbin/apache2ctl -D FOREGROUND


COPY . /var/www/html/

EXPOSE 80
