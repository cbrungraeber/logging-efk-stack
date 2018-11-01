################################################################################
ARG JDK_VERSION
ARG TOMCAT_VERSION



################################################################################
FROM openjdk:$JDK_VERSION as tomcatbuildstage

COPY tomcat-slf4j-logback/ /build/
COPY patch/tomcat.patch /build/

WORKDIR /build/

RUN apt-get update \
    && apt-get install --no-install-recommends -y patch \
    && patch -p2 < ./tomcat.patch

ENV MAVEN_OPTS=-Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn
RUN ./mvnw --batch-mode --projects tomcat9 --also-make clean package -DskipTests=true -Dlicense.skip=true





################################################################################
FROM openjdk:$JDK_VERSION as appbuildstage

COPY hello/ /build/
WORKDIR /build/

# https://stackoverflow.com/questions/21638697/disable-maven-download-progress-indication
# https://www.baeldung.com/spring-boot-war-tomcat-deploy

ENV MAVEN_OPTS=-Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn
RUN ./mvnw --batch-mode clean package -DskipTests=true



################################################################################
# https://hub.docker.com/_/tomcat/
FROM tomcat:$TOMCAT_VERSION as runstage

COPY --from=tomcatbuildstage /build/tomcat9/target/tomcat-juli-*.zip ./tomcat-juli.zip
COPY --from=appbuildstage /build/target/hello.war ./webapps/

# https://www.elastic.co/guide/en/apm/agent/java/current/intro.html
# https://search.maven.org/search?q=g:co.elastic.apm%20AND%20a:elastic-apm-agent
RUN curl --silent https://search.maven.org/remotecontent?filepath=co/elastic/apm/elastic-apm-agent/0.7.1/elastic-apm-agent-0.7.1.jar --output ./elastic-apm-agent.jar

# https://jolokia.org/tutorial.html
# https://search.maven.org/search?q=a:jolokia-war
RUN curl --silent https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-war/1.6.0/jolokia-war-1.6.0.war --output ./webapps/jolokia.war

# https://stackoverflow.com/questions/36703856/access-tomcat-manager-app-from-different-host
COPY ./config/tomcat-users.xml ./conf/tomcat-users.xml
COPY ./config/manager.xml ./conf/Catalina/localhost/manager.xml
COPY ./config/jolokia.xml ./conf/Catalina/localhost/jolokia.xml

RUN unzip -o ./tomcat-juli.zip \
    && rm ./tomcat-juli.zip \
    && rm ./conf/logging.properties



# Tomcat, SLF4J and Logback integration
# https://github.com/tomcat-slf4j-logback/tomcat-slf4j-logback#quick-start
# RUN curl --silent https://search.maven.org/remotecontent?filepath=com/github/tomcat-slf4j-logback/tomcat9-slf4j-logback/9.0.12/tomcat9-slf4j-logback-9.0.12-9.0.12-slf4j-1.7.25-logback-1.2.3.zip --output tomcat9-slf4j.zip \
#    && unzip -o tomcat9-slf4j.zip \
#    && rm ./tomcat9-slf4j.zip \
#    && rm ./conf/logging.properties

# COPY ./config/logback.xml ./conf/logback.xml

# Add dependencies for Logback JSON Encoder
# https://github.com/logstash/logstash-logback-encoder
#RUN curl --silent https://search.maven.org/remotecontent?filepath=ch/qos/logback/logback-core/1.2.3/logback-core-1.2.3.jar --output ./lib/logback-core-1.2.3.jar \
#    && curl --silent https://search.maven.org/remotecontent?filepath=ch/qos/logback/logback-classic/1.2.3/logback-classic-1.2.3.jar --output ./lib/logback-classic-1.2.3.jar \
#    && curl --silent https://search.maven.org/remotecontent?filepath=ch/qos/logback/logback-access/1.2.3/logback-access-1.2.3.jar --output ./lib/logback-access-1.2.3.jar \
#    && curl --silent https://search.maven.org/remotecontent?filepath=org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar --output ./lib/slf4j-api-1.7.25.jar \
#    && curl --silent https://search.maven.org/remotecontent?filepath=com/fasterxml/jackson/core/jackson-databind/2.9.7/jackson-databind-2.9.7.jar --output ./lib/jackson-databind-2.9.7.jar \
#    && curl --silent https://search.maven.org/remotecontent?filepath=com/fasterxml/jackson/core/jackson-core/2.9.7/jackson-core-2.9.7.jar --output ./lib/jackson-core-2.9.7.jar \
#    && curl --silent https://search.maven.org/remotecontent?filepath=com/fasterxml/jackson/core/jackson-annotations/2.9.7/jackson-annotations-2.9.7.jar --output ./lib/jackson-annotations-2.9.7.jar \
#    && curl --silent https://search.maven.org/remotecontent?filepath=net/logstash/logback/logstash-logback-encoder/5.2/logstash-logback-encoder-5.2.jar --output ./lib/logstash-logback-encoder-5.2.jar

# RUN curl --silent https://search.maven.org/remotecontent?filepath=net/logstash/logback/logstash-logback-encoder/5.2/logstash-logback-encoder-5.0.jar --output ./lib/logstash-logback-encoder-5.0.jar
