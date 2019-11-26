passwd ftpuser << PASSWORD
pass
pass
PASSWORD
sh /bin/startscript/start-telegraf.sh
screen -dmS ftps vsftpd /etc/vsftpd/vsftpd.conf
