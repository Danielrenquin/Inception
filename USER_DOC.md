# User Documentation

## Services provided
- Nginx: HTTPS reverse proxy (port 443)
- WordPress: website application (PHP‑FPM)
- MariaDB: database backend

## Start and stop
- Start: make all
- Stop: make down

## Access the website
1. Map the domain to your local IP (example in /etc/hosts):
   127.0.0.1 daniel.42.fr
2. Open https://daniel.42.fr

## Access the admin panel
Open https://daniel.42.fr/wp-admin and log in with the WordPress admin account.

## Credentials management
Secrets are stored locally and ignored by git:
- secrets/db_root_password.txt
- secrets/db_password.txt
- secrets/db_admin_password.txt
Non‑secret configuration is stored in srcs/.env.

## Check services status
- docker compose -f srcs/docker-compose.yml ps
- docker compose -f srcs/docker-compose.yml logs -f