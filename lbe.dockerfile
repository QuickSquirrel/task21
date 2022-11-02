FROM alpine:3.16.2
RUN apk add --no-cache nginx openrc nginx-mod-http-image-filter nginx-mod-http-upstream-fair; \
    mkdir -p /run/openrc; \
    mkdir -p /usr/share/nginx/html/music; \
    mkdir -p /usr/share/nginx/html/img; \
    mkdir -p /usr/share/nginx/html/p8080; \
    mkdir -p /usr/share/nginx/html/content; \
    touch /run/openrc/softlevel; \
    /sbin/openrc 2>/dev/unll; \
    rc-update add nginx default;
COPY nginx.conf /etc/nginx/
COPY upstreams.conf /etc/nginx/conf.d/
COPY default.conf /etc/nginx/http.d/
COPY index.html /usr/share/nginx/html/
COPY /img/* /usr/share/nginx/html/img/
COPY /music/* /usr/share/nginx/html/music/
COPY /p8080/* /usr/share/nginx/html/p8080/
COPY /content/* /usr/share/nginx/html/content/
COPY start.sh /opt/
ENV REDIP=127.0.0.1
ENV BLUEIP=127.0.0.1
EXPOSE 80
EXPOSE 8080
CMD /bin/sh /opt/start.sh; nginx -g "daemon off;"
