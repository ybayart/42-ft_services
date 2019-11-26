sh /bin/startscript/start-telegraf.sh
passwd ybayart << PASSWORD
motdepasse
motdepasse
PASSWORD

ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
mkdir -p /var/run/sshd

mkdir /run/nginx
nginx
php-fpm7
screen -dmS ssh /usr/sbin/sshd -D
