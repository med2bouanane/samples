FROM maven:3.9.5-eclipse-temurin-21 AS build
WORKDIR /app
ARG MODULE_DIR=01-helm
# Parent POM
COPY pom.xml ./pom.xml
COPY ${MODULE_DIR}/pom.xml ./helm/pom.xml
#RUN mvn dependency:go-offline -B
COPY ${MODULE_DIR}/src ./helm/src
RUN mvn -f ./helm/pom.xml clean package -DskipTests

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/helm/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
