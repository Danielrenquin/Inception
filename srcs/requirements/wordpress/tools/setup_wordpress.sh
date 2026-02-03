#!/bin/sh

set -e

WP_PATH=/var/www/html

echo "Starting WordPress setup..."

# Télécharger WordPress si pas déjà présent (volume persistant)
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo "Downloading WordPress..."
    curl -s https://wordpress.org/latest.tar.gz -o /tmp/wordpress.tar.gz
    tar -xzf /tmp/wordpress.tar.gz -C /tmp
    mkdir -p $WP_PATH
    cp -r /tmp/wordpress/* $WP_PATH
    rm -rf /tmp/wordpress /tmp/wordpress.tar.gz

    echo "Configuring WordPress..."

    cp $WP_PATH/wp-config-sample.php $WP_PATH/wp-config.php

    sed -i "s/database_name_here/$MYSQL_DATABASE/g" $WP_PATH/wp-config.php
    sed -i "s/username_here/$MYSQL_USER/g" $WP_PATH/wp-config.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" $WP_PATH/wp-config.php
    sed -i "s/localhost/$MYSQL_HOST/g" $WP_PATH/wp-config.php

    chown -R www-data:www-data $WP_PATH
fi

# Lancer PHP-FPM en premier plan (PID 1)
exec /usr/sbin/php-fpm8.2 -F
