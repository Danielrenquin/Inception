FROM debian:12.13-slim

RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client \ 
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/setup_mariadb.sh /setup_mariadb.sh

RUN chmod +x /setup_mariadb.sh

EXPOSE 3306

ENTRYPOINT ["/setup_mariadb.sh"]