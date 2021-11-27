FROM maven:3.3-jdk-8 AS build
WORKDIR /app
COPY . ./build/
WORKDIR /app/build/
RUN mvn clean install

FROM openjdk:8-jdk-alpine AS runtime
WORKDIR /app
ARG JAR_FILE=/app/build/target/*.jar
COPY --from=build ${JAR_FILE} /app/rabbitmq-producer-springboot.jar
ENTRYPOINT ["java","-jar","/app/rabbitmq-producer-springboot.jar"]