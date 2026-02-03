#!/bin/bash

set -e

# Créer les répertoires nécessaires
mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql
chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql

# Initialiser MariaDB si pas déjà fait
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database system..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db
fi

# Démarrer MariaDB temporairement pour la configuration
echo "Starting MariaDB for configuration..."
mariadbd --user=mysql --datadir=/var/lib/mysql --skip-networking &
MYSQL_PID=$!

# Attendre que MariaDB soit prêt
echo "Waiting for MariaDB to start..."
until mysqladmin ping --silent; do
    sleep 1
done
echo "MariaDB is ready"

# Créer la base de données et les utilisateurs si la base n'existe pas
if ! mysql -u root -e "USE ${MYSQL_DATABASE};" 2>/dev/null; then
    echo "Creating database and users..."
    mysql -u root <<-EOSQL
        -- Sécuriser l'installation
        DELETE FROM mysql.user WHERE User='';
        DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
        DROP DATABASE IF EXISTS test;
        
        -- Définir le mot de passe root
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        
        -- Créer la base de données WordPress
        CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
        
        -- Créer l'utilisateur WordPress (utilisateur normal)
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
        
        -- Créer un utilisateur administrateur (pas admin/administrator)
        CREATE USER IF NOT EXISTS '${MYSQL_ADMIN_USER}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';
        GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN_USER}'@'%' WITH GRANT OPTION;
        
        -- Appliquer les privilèges
        FLUSH PRIVILEGES;
EOSQL
    echo "Database and users created successfully"
else
    echo "Database ${MYSQL_DATABASE} already exists, skipping creation"
fi

# Arrêter le processus temporaire
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
wait $MYSQL_PID 2>/dev/null || true

echo "MariaDB initialization complete"

# Lancer MariaDB en premier plan (PID 1)
echo "Starting MariaDB server..."
exec mariadbd --user=mysql --datadir=/var/lib/mysql
