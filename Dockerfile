FROM Maven as build1
WORKDIR /app/
COPY . /app/
RUN mvn install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build1 /app/target/Uber.jar /app/
EXPOSE 9090
CMD ["java", "-jar", "Uber.jar"] 