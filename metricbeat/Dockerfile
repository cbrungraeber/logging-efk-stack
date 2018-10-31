# https://www.elastic.co/guide/en/beats/metricbeat/current/running-on-docker.html
ARG VERSION
FROM docker.elastic.co/beats/metricbeat:$VERSION

COPY ./config/metricbeat.yml /usr/share/metricbeat/metricbeat.yml
USER root
RUN chown root:metricbeat /usr/share/metricbeat/metricbeat.yml

# USER metricbeat