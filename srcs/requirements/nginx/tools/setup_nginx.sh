#!/bin/sh

set -e

mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/nginx.key \
  -out /etc/nginx/ssl/nginx.crt \
  -subj "/C=BE/ST=LUX/L=BRUXELLES/O=42/OU=42/CN=${DOMAIN_NAME}"

nginx -t

exec nginx -g "daemon off;"