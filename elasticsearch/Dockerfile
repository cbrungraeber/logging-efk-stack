ARG VERSION
FROM docker.elastic.co/elasticsearch/elasticsearch-oss:$VERSION

COPY ./config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

# Healthcheck
# https://github.com/docker-library/healthcheck
COPY docker-healthcheck /usr/local/bin/
HEALTHCHECK CMD ["docker-healthcheck"]
