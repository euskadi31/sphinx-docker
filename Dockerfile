FROM alpine:latest
MAINTAINER Axel Etcheverry <axel@etcheverry.biz>
HEALTHCHECK --interval=10s --timeout=2s CMD mysql -P9306 --protocol=tcp -e "show databases;" > /dev/null 2>&1 || exit 1
RUN apk update && apk add sphinx mysql-client && rm -rf /var/cache/apk/*
EXPOSE 9306 9312
VOLUME /var/lib/sphinx /etc/sphinx
RUN ln -sf /dev/stdout /var/log/searchd.log
#RUN ln -sf /dev/stdout /var/log/query.log
COPY sphinx.conf /etc/sphinx/sphinx.conf
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["searchd", "--nodetach"]
