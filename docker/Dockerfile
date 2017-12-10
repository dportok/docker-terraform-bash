FROM redis:4
LABEL maintainer="dportok@gmail.com"
ENV REDIS_PORT_NUMBER 8000 \ 
    MAX_MEMORY 128mb
COPY redis.conf /usr/local/etc/redis/redis.conf
COPY docker-entrypoint.sh /
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT [ "sh", "-c", "/docker-entrypoint.sh ${REDIS_PORT_NUMBER} ${MAX_MEMORY}" ]