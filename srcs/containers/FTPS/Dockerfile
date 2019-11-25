FROM alpine:latest
MAINTAINER ybayart
RUN apk add --no-cache vsftpd
COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY srcs/start-ftps.sh /bin/start-ftps.sh
#RUN mkdir -p /var/ftp/pub
#RUN chown nobody:nogroup /var/ftp/pub
#RUN echo "anon" | tee /var/ftp/pub/test.txt
###RUN apk --no-cache add libressl lftp
CMD sh /bin/start-ftps.sh && tail -F /dev/null
