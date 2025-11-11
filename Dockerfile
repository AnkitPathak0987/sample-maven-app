# Use official OpenJDK 17 image as base
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the built JAR file from Jenkins build
COPY target/sample-app-1.0-SNAPSHOT.jar app.jar

# Expose port (optional)
EXPOSE 8080

# Run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
