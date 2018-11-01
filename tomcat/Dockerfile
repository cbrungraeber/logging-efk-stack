ARG JDK_VERSION
ARG TOMCAT_VERSION

FROM openjdk:$JDK_VERSION as buildstage

COPY hello/ /build/
WORKDIR /build

# https://stackoverflow.com/questions/21638697/disable-maven-download-progress-indication
# https://www.baeldung.com/spring-boot-war-tomcat-deploy

ENV MAVEN_OPTS=-Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn
RUN ./mvnw --batch-mode clean package



# https://hub.docker.com/_/tomcat/
FROM tomcat:$TOMCAT_VERSION as runstage

COPY --from=buildstage /build/target/hello.war ./webapps/

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
