# Use official Eclipse Temurin OpenJDK 17 image
FROM eclipse-temurin:17-jdk-jammy

# Set working directory
WORKDIR /app

# Copy built JAR file from target folder
COPY target/sample-app-1.0-SNAPSHOT.jar app.jar

# Expose port 8080 (optional)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
