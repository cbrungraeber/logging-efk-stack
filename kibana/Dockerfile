ARG VERSION
FROM docker.elastic.co/kibana/kibana-oss:$VERSION

COPY ./config/ /usr/share/kibana/config

# HEALTHCHECK CMD ["curl", "-f", "http://localhost:5601"]