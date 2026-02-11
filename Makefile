.PHONY: all build up down clean fclean re logs prepare

all: prepare build up

prepare:
	mkdir -p /home/daniel/data/wordpress /home/daniel/data/mariadb

build:
	docker compose -f srcs/docker-compose.yml build

up:
	docker compose -f srcs/docker-compose.yml up -d

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker compose -f srcs/docker-compose.yml down -v

fclean: clean
	docker system prune -af --volumes

re: fclean all

logs:
	docker compose -f srcs/docker-compose.yml logs -f
