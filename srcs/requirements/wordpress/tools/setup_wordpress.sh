#!/bin/sh

set -e

WP_PATH=/var/www/html
WP_CLI_BIN=/usr/local/bin/wp

if [ -n "${MYSQL_PASSWORD_FILE:-}" ] && [ -f "$MYSQL_PASSWORD_FILE" ]; then
    MYSQL_PASSWORD=$(cat "$MYSQL_PASSWORD_FILE")
    export MYSQL_PASSWORD
fi

if [ -n "${WP_ADMIN_PASSWORD_FILE:-}" ] && [ -f "$WP_ADMIN_PASSWORD_FILE" ]; then
    WP_ADMIN_PASSWORD=$(cat "$WP_ADMIN_PASSWORD_FILE")
    export WP_ADMIN_PASSWORD
fi

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

# Installer WP-CLI si nécessaire
if [ ! -x "$WP_CLI_BIN" ]; then
    echo "Installing WP-CLI..."
    curl -s https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /tmp/wp-cli.phar
    chmod +x /tmp/wp-cli.phar
    mv /tmp/wp-cli.phar "$WP_CLI_BIN"
fi

# Attendre que MariaDB soit prêt
echo "Waiting for database..."
until php -r "@mysqli_connect('$MYSQL_HOST', '$MYSQL_USER', '$MYSQL_PASSWORD', '$MYSQL_DATABASE') or exit(1);"; do
    sleep 2
done

# Installer WordPress automatiquement si pas déjà installé
if ! "$WP_CLI_BIN" core is-installed --path="$WP_PATH" --allow-root; then
    echo "Installing WordPress..."
    "$WP_CLI_BIN" core install \
        --path="$WP_PATH" \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root
fi

# Lancer PHP-FPM en premier plan (PID 1)
exec /usr/sbin/php-fpm8.2 -F

