FROM telegraf:v1
MAINTAINER ybayart
RUN apk add vsftpd openssl
RUN adduser -D ftpuser
RUN mkdir -p /home/ftpuser/ftp /etc/ssl/private /var/run/vsftpd/empty
RUN chown nobody:nogroup /home/ftpuser/ftp && chmod a-w /home/ftpuser/ftp
RUN echo "ftpuser" | tee -a /etc/vsftpd/vsftpd.userlist
RUN echo "Tu es connecté" > /home/ftpuser/ftp/hello.txt
RUN sed -i -e "s/TMPBDD/ftps/g" /etc/telegraf/telegraf.conf
COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY srcs/vsftpd.conf /etc/vsftpd.conf
#COPY srcs/vsftpd /etc/pam.d/
COPY srcs/*.pem /etc/ssl/private/
COPY srcs/start-ftps.sh /bin/startscript/start-ftps.sh
CMD sh /bin/startscript/start-ftps.sh && tail -F /dev/null

EXPOSE 20 21 30000
