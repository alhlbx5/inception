#!/bin/bash

if [ ! -d "/var/lib/mysql/wordpress" ]; then
    
    service mysql start

    mysql_secure_installation << EOF

y
secret42
secret42
y
n
y
y
EOF

    mysql -u root -psecret42 << EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'aalhalab'@'%' IDENTIFIED BY 'dbpass42';
GRANT ALL PRIVILEGES ON wordpress.* TO 'aalhalab'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'secret42';
FLUSH PRIVILEGES;
EOF

    service mysql stop
fi

mysqld_safe