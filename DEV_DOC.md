# Developer Documentation

## Overview
This document explains how to set up, build, and manage the Inception stack as a developer.

## Prerequisites
- Linux VM (required by the subject)
- Docker + Docker Compose
- Git

## Repository structure
- Makefile at the root
- srcs/ contains docker-compose.yml and service requirements
- secrets/ contains local secrets (ignored by git)
- docs/ contains additional documentation

## Environment setup
1. Create your secrets locally (ignored by git):
   - secrets/db_root_password.txt
   - secrets/db_password.txt
   - secrets/db_admin_password.txt
2. Edit srcs/.env for non‑secret configuration:
   - DOMAIN_NAME
   - DATA_PATH
   - MYSQL_* usernames and database

## Build and launch
- Build images: make build
- Start containers: make up
- Build + start: make all

## Manage containers and volumes
- Stop containers: make down
- Remove containers + volumes: make clean
- Full cleanup (containers, images, volumes): make fclean
- View logs: make logs

Useful Docker commands:
- docker compose -f srcs/docker-compose.yml ps
- docker compose -f srcs/docker-compose.yml exec nginx sh
- docker volume ls

## Data persistence
Named volumes are mapped to host directories under /home/daniel/data:
- /home/daniel/data/wordpress
- /home/daniel/data/mariadb
These paths are configured via DATA_PATH in srcs/.env and the driver_opts section in srcs/docker-compose.yml.