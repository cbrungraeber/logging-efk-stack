# EFK

- [docker](https://www.docker.com/)
- [docker-compose](https://docs.docker.com/compose/)
- [Elasticsearch OSS](https://www.elastic.co/de/products/elasticsearch)
- [Kibana OSS](https://www.elastic.co/de/products/kibana)
- [Fluentd](https://www.fluentd.org/)
- [fluent-plugin-elasticsearch](https://github.com/uken/fluent-plugin-elasticsearch)
- [fluent-plugin-rewrite-tag-filter](https://github.com/fluent/fluent-plugin-rewrite-tag-filter)
- [fluent-plugin-geoip](https://github.com/y-ken/fluent-plugin-geoip)
- [MaxMind GeoLite2 DB](https://github.com/maxmind/libmaxminddb)
- [nginx](https://www.nginx.com/)
- Simple Java application built with [gradle](https://gradle.org/)
- [logstash-logback-encoder](https://github.com/logstash/logstash-logback-encoder)
- [cerebro](https://github.com/lmenezes/cerebro)
- [apm-server](https://www.elastic.co/solutions/apm)
- [metricbeat](https://www.elastic.co/de/products/beats/metricbeat)

## Sending Arbitrary Events to Fluentd

It is pretty easy to send arbitrary events to Fluentd Using curl and the [HTTP input plugin](https://docs.fluentd.org/v1.0/articles/in_http) listening at port 9800.

Here is a simple example to post a record with the tag `nginx`, which will be parsed by the [nginx parser plugin](https://docs.fluentd.org/v1.0/articles/parser_nginx)

```
$ curl -X POST -d @events/nginx.json -H 'Content-Type: application/json' http://localhost:9880/nginx
```
