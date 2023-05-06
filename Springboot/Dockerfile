#Start with a base image containing Java runtime
FROM amazoncorretto:11-alpine-jdk
MAINTAINER ramses
RUN addgroup -S api-test && adduser -S api-test -G api-test
USER api-test:api-test
# Add a volume pointing to /gedoc
VOLUME /api-test
# Make port 9008 available to the world outside this container
EXPOSE 9063
# The application's jar file
ARG JAR_FILE=target/test-0.0.1-SNAPSHOT.jar
# Add the application's jar to the container
COPY ${JAR_FILE} api-test.jar
# Run the jar file
CMD ["java", "-jar", "api-test.jar" ,"--spring.config.location=file:/api-test/config/application.properties" ]
