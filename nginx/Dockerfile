ARG VERSION
FROM nginx:$VERSION

RUN apt-get update \
    && apt-get install --no-install-recommends -y curl

COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./static/ /usr/share/nginx/html/

HEALTHCHECK CMD ["curl", "-f", "http://localhost"]
