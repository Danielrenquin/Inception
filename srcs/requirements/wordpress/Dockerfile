FROM debian:12.13-slim

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-gd \
    php-xml \
    php-mbstring \
    php-zip \
    php-curl \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/php/8.2/fpm/pool.d/www.conf

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/setup_wordpress.sh /setup_wordpress.sh

RUN chmod +x /setup_wordpress.sh

EXPOSE 9000

ENTRYPOINT [ "/setup_wordpress.sh"]