FROM java:11-jdk
COPY ./target/cybertek-0.0.1-SNAPSHOT.jar/usr/app/
WORKDIR /usr/app
RUN sh -c 'touch cybertek-0.0.1-SNAPSHOT.jar'
EXPOSE 8080
ENTRYPOINT ["java","-jar","cybertek-0.0.1-SNAPSHOT.jar"]





