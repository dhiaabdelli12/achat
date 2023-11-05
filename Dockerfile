FROM openjdk:8-jdk-alpine
EXPOSE 8082
ADD . /
ENTRYPOINT ["java","-jar","/"]
