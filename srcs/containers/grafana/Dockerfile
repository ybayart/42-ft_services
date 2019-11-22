FROM alpine:latest
MAINTAINER ybayart
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk add --no-cache grafana@testing
COPY srcs/start-grafana.sh /bin/start-grafana.sh
CMD sh /bin/start-grafana.sh && tail -F /dev/null
