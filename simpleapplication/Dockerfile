FROM openjdk:8 AS buildstage

WORKDIR /build

COPY . .

RUN ./gradlew build \
    && unzip ./build/distributions/logback-logstash-1.0-SNAPSHOT.zip

FROM openjdk:8-jre AS runstage

COPY --from=buildstage /build/logback-logstash-1.0-SNAPSHOT/ /application
WORKDIR /application

ENTRYPOINT [ "./bin/logback-logstash" ]
