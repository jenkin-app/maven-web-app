FROM tomcat:9.0-jre8-openjdk-bullseye
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps
COPY target/maven-web-app.war /usr/local/tomcat/webapps
