FROM telegraf:v1
MAINTAINER ybayart
RUN apk add vsftpd
RUN adduser -D ftpuser
RUN mkdir -p /home/ftpuser/ftp /etc/ssl/private /var/run/vsftpd/empty
RUN chown nobody:nogroup /home/ftpuser/ftp && chmod a-w /home/ftpuser/ftp
RUN echo "ftpuser" | tee -a /etc/vsftpd.userlist
RUN echo "Tu es connecté" > /home/ftpuser/ftp/hello.txt
RUN sed -i -e "s/TMPBDD/ftps/g" /etc/telegraf/telegraf.conf
COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY srcs/vsftpd.conf /etc/vsftpd.conf
COPY srcs/start-ftps.sh /bin/startscript/start-ftps.sh
COPY srcs/vsftpd.pem /etc/ssl/private/vsftpd.pem
CMD sh /bin/startscript/start-ftps.sh && tail -F /dev/null
