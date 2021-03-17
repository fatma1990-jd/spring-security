FROM adoptopenjdk/openjdk11 as build
#FROM openjdk:8-jdk-alpine as build
MAINTAINER cybertek.com
COPY  jd-ticketing.jar /
ENTRYPOINT ["java","-jar","/jd-ticketing.jar"]
