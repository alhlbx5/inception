FROM debian:buster

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY tools/check-ssl.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/check-ssl.sh

EXPOSE 443

CMD ["sh", "-c", "check-ssl.sh && nginx -g 'daemon off;'"]