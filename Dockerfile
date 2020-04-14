FROM alpine:edge
RUN apk add --no-cache openjdk11
COPY build/libs/pokemon-deck-wizard-0.0.1-SNAPSHOT.jar /opt/spring-cloud/lib/
ENTRYPOINT ["/usr/bin/java"]
CMD ["-jar", "/opt/spring-cloud/lib/pokemon-deck-wizard-0.0.1-SNAPSHOT.jar"]
EXPOSE 8080
