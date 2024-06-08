FROM alpine:3

RUN apk add --no-cache --update postfix bash gettext && \
    apk add --no-cache --upgrade musl musl-utils && \
    (rm "/tmp/"* 2>/dev/null || true) && (rm -rf /var/cache/apk/* 2>/dev/null || true)

ADD entrypoint.sh /entrypoint.sh
ADD main.cf.tmpl /etc/postfix/main.cf.tmpl

VOLUME /var/spool/postfix

EXPOSE 25
EXPOSE 587

STOPSIGNAL SIGKILL
ENTRYPOINT ["/entrypoint.sh"]