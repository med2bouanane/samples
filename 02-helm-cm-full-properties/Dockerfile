FROM maven:3.9.5-eclipse-temurin-21 AS build
WORKDIR /app
ARG MODULE_DIR=02-helm-cm-full-properties
# Parent POM
COPY pom.xml ./pom.xml
COPY ${MODULE_DIR}/pom.xml ./helmcm/pom.xml
RUN mvn -f ./helmcm/pom.xml dependency:go-offline -B
COPY ${MODULE_DIR}/src ./helmcm/src
RUN mvn -f ./helmcm/pom.xml clean package -DskipTests

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/helmcm/target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]
