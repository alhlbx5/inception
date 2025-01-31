FROM debian:buster

RUN apt-get update && apt-get -y install \
    php7.3-fpm \
    php7.3-mysql \
    php7.3-json \
    php7.3-curl \
    php7.3-gd \
    php7.3-xml \
    php7.3-mbstring \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY conf/www.conf /etc/php/7.3/fpm/pool.d/
RUN mkdir -p /run/php

WORKDIR /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp-cli

COPY tools/wp-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-setup.sh

EXPOSE 9000

ENTRYPOINT ["wp-setup.sh"]