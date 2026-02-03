FROM debian:12.13-slim

RUN apt-get update && apt-get install -y \
    openssl \
    nginx \
    && rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/nginx/nginx.conf

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/setup_nginx.sh /setup_nginx.sh

RUN chmod +x /setup_nginx.sh

EXPOSE 443

ENTRYPOINT [ "/setup_nginx.sh" ]