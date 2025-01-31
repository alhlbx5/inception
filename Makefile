NAME = inception
USER = aalhalab

all: dirs up

dirs:
	mkdir -p /home/$(USER)/data/mysql
    mkdir -p /home/$(USER)/data/wordpress

up:
	docker-compose -f srcs/docker-compose.yml up --build -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -af
	sudo rm -rf /home/$(USER)/data

re: clean all

.PHONY: all dirs up down clean re