FROM openjdk:8-jdk-alpine
RUN ls
RUN ls /
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY src ./src
COPY target ./target
RUN ls
CMD ["./mvnw", "spring-boot:run"]
RUN ls
COPY target/app.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]