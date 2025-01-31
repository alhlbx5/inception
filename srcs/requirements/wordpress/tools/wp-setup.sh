cat > srcs/requirements/wordpress/tools/wp-setup.sh << EOF
#!/bin/bash

while ! mysql -h mariadb -u \${MYSQL_USER} -p\${MYSQL_PASSWORD} \${MYSQL_DATABASE} 2>/dev/null; do
    sleep 3
done

cd /var/www/html

if [ ! -f "wp-config.php" ]; then
    wp-cli core download --allow-root
    wp-cli config create --dbname=\${MYSQL_DATABASE} \
                        --dbuser=\${MYSQL_USER} \
                        --dbpass=\${MYSQL_PASSWORD} \
                        --dbhost=mariadb \
                        --allow-root

    wp-cli core install --url=\${DOMAIN_NAME} \
                       --title="aalhalab's Site" \
                       --admin_user=\${WP_ADMIN_USER} \
                       --admin_password=\${WP_ADMIN_PASSWORD} \
                       --admin_email=\${WP_ADMIN_EMAIL} \
                       --allow-root
fi

chown -R www-data:www-data /var/www/html
php-fpm7.3 -F
EOF

chmod +x srcs/requirements/wordpress/tools/wp-setup.sh