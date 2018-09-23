#!/bin/bash

find /var/lib/mysql/mysql -exec touch -c -a {} + && service mysql start
# mysqld_safe &

while !(mysqladmin ping)
do
	sleep 3
	echo "waiting for mysql ..."
done

mysql -uroot  -e "UPDATE mysql.user SET Password=PASSWORD('root') WHERE User='root'"
mysql -uroot  -e "FLUSH PRIVILEGES"

# mysql -uroot -e ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY 'root'"

rails db:create:all
rails db:migrate -e production 
rails server -b 0.0.0.0 -e production
