sh /bin/startscript/start-telegraf.sh
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql
mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

tfile=`mktemp`
cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "motdepasse" WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
ALTER USER 'root'@'localhost' IDENTIFIED BY '';
CREATE USER 'web'@'%' IDENTIFIED BY 'motdepasse';
GRANT ALL ON *.* TO 'web'@'%';
CREATE DATABASE wordpress;
FLUSH PRIVILEGES;
EOF

echo "toto"
#/usr/bin/mysqld_safe –skip-grant-tables –skip-networking < $tfile
/usr/bin/mysqld --user=mysql --bootstrap --verbose=0 --skip-name-resolve --skip-networking=0 < $tfile
rm -f $tfile

echo "tata"
screen -dmS mysql /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0

echo "Waiting"
while ! mysqladmin ping
do
	sleep 1
done

echo "Importing dump"
mysql -u root wordpress < /bin/startscript/wordpress.sql
