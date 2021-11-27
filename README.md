# rabbitmq-producer-springboot
Aplicação curso RabbitMQ para produzir mensagens em uma fila.

## Variáveis de ambiente do application.yml

```yaml
server:
  port: ${PRODUCER_PORT:8081}
spring:
  rabbitmq:
    host: ${MQ_HOST:localhost}
    port: ${MQ_PORT:5672}
    username: ${MQ_USER:guest}
    password: ${MQ_PASS:guest}
```

## Exemplo de execução 

```shell
docker build -t rabbitmq-producer-springboot .
docker run -d -p 8081:8081 -e MQ_HOST=192.168.0.209 rabbitmq-producer-springboot
```

## Dockerfile
```dockerfile
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
```

## Fonte
https://www.udemy.com/course/rabbitmq-com-springboot-e-docker/
