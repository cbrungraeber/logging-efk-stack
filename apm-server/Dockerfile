# https://www.elastic.co/guide/en/apm/server/current/running-on-docker.html

ARG VERSION
FROM docker.elastic.co/apm/apm-server:$VERSION

COPY ./config/apm-server.yml /usr/share/apm-server/apm-server.yml
USER root
RUN chown apm-server /usr/share/apm-server/apm-server.yml
USER apm-server