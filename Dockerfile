FROM alpine:3.15.0 as latest

ENV TEMP=/tmp \
    ENV=/etc/profile \
    CLEAN="/var/cache/apk/:/tmp/"

RUN adduser -u 1000 -S -s /bin/sh -G users user && echo "user:password" | chpasswd 2>/dev/null

COPY rootfs /

RUN ["chmod", "+x", "/docker-entrypoint.sh"]

RUN apk --no-cache --update upgrade && apk --update --no-cache add su-exec tini ca-certificates gettext ghostscript && mv /usr/bin/envsubst /usr/local/bin/ && apk del gettext

ENTRYPOINT [ "/docker-entrypoint.sh" ]

CMD [ "gs" ]
