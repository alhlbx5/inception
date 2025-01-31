NAME = inception
USER = aalhalab

all: dirs ssl up

dirs:
   mkdir -p /home/$(USER)/data/mysql
   mkdir -p /home/$(USER)/data/wordpress
   mkdir -p /home/$(USER)/data/nginx/ssl

ssl:
   if [ ! -f /home/$(USER)/data/nginx/ssl/nginx.crt ]; then \
   	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
   	-keyout /home/$(USER)/data/nginx/ssl/nginx.key \
   	-out /home/$(USER)/data/nginx/ssl/nginx.crt \
   	-subj "/C=MA/ST=BG/L=BG/O=42/OU=42/CN=aalhalab.42.fr"; \
   fi

up:
   docker-compose -f srcs/docker-compose.yml up --build -d

down:
   docker-compose -f srcs/docker-compose.yml down

clean: down
   docker system prune -af
   rm -rf /home/$(USER)/data

re: clean all

.PHONY: all dirs ssl up down clean re