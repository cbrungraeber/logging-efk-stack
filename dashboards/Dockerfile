FROM alpine:latest

ARG APP_DIR=/opt/app
WORKDIR $APP_DIR

COPY src .

RUN apk add --no-cache bash curl

ENV ELASTICSEARCH=elasticsearch:9200

CMD ["./restore.sh"]
