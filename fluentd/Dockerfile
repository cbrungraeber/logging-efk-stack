ARG VERSION
FROM fluent/fluentd:$VERSION

# Fix super-slow alpine server
# Install GeoIP library and deps
# Install fluentd plugins
# https://docs.fluentd.org/v1.0/articles/filter_geoip
# https://github.com/fluent/fluentd-docker-image/issues/22
# https://docs.fluentd.org/v1.0/articles/out_elasticsearch
RUN echo "http://nl.alpinelinux.org/alpine/v3.7/main" > /tmp/repositories \
    && echo "http://nl.alpinelinux.org/alpine/v3.7/community" >> /tmp/repositories \
    && cat /etc/apk/repositories >> /tmp/repositories \
    && cp /tmp/repositories /etc/apk/repositories \
    \
    && apk add --no-cache --update build-base autoconf ruby-dev geoip-dev libmaxminddb-dev \
    \
    && fluent-gem install fluent-plugin-elasticsearch \
    && fluent-gem install fluent-plugin-rewrite-tag-filter \
    && fluent-gem install fluent-plugin-geoip \
    \
    && apk del build-base autoconf ruby-dev \
    && rm -rf /tmp/* /var/tmp/* /var/cache/apk/* \
    \
    && curl --silent -O http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz \
    && gunzip GeoLite2-City.mmdb.gz

COPY ./config/ /fluentd/etc/
COPY ./templates/fluentd.json /