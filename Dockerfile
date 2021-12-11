FROM openjdk:11-jdk-alpine
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY src ./src
CMD ["./mvnw", "spring-boot:run"]
#RUN ls
#COPY target/app.jar app.jar
#ENTRYPOINT ["java","-jar","app.jar"]