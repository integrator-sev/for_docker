FROM ubuntu:16.04
RUN apt update
RUN apt upgrade -y
RUN apt install default-jdk wget tar maven git -y
RUN wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.58/bin/apache-tomcat-8.5.58.tar.gz
RUN mkdir /opt/tomcat
RUN tar xvf apache-tomcat-*tar.gz -C /opt/tomcat --strip-components=1
RUN mkdir /opt/git
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /opt/git/boxfuse-sample-java-war-hello/
RUN mvn clean package -f /opt/git/boxfuse-sample-java-war-hello/pom.xml
RUN cp /opt/git/boxfuse-sample-java-war-hello/target/*.war /opt/tomcat/webapps/test.war
EXPOSE 8080
ENTRYPOINT ["/opt/tomcat/bin/catalina.sh", "run"]