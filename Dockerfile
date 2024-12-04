FROM openjdk:11 AS BUILD_IMAGE
RUN apt update && apt install -y maven git
RUN git clone https://github.com/LinuxHunt-Nexus/cicd-kube-docker.git
WORKDIR cicd-kube-docker
RUN mvn clean install -DskipTests

FROM tomcat:9-jre11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE cicd-kube-docker/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
