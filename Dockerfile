# ================================
# Mahesh Shopping - Custom Dockerfile
# Base: Java 11 + Tomcat 9
# ================================

FROM openjdk:11-jdk-slim

LABEL maintainer="Mahesh Shopping"
LABEL description="Mahesh Shopping TShirt App on Tomcat"

# Set environment variables
ENV CATALINA_HOME=/opt/tomcat
ENV JAVA_HOME=/usr/local/openjdk-11
ENV PATH=$CATALINA_HOME/bin:$JAVA_HOME/bin:$PATH
ENV TOMCAT_VERSION=9.0.85

# Install required tools
RUN apt-get update && \
    apt-get install -y curl wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install Tomcat
RUN mkdir -p /opt/tomcat && \
    wget -q https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tar.gz && \
    tar -xzf /tmp/tomcat.tar.gz -C /opt/tomcat --strip-components=1 && \
    rm /tmp/tomcat.tar.gz

# Remove default Tomcat apps (optional - keeps it clean)
RUN rm -rf $CATALINA_HOME/webapps/ROOT \
           $CATALINA_HOME/webapps/examples \
           $CATALINA_HOME/webapps/docs \
           $CATALINA_HOME/webapps/host-manager \
           $CATALINA_HOME/webapps/manager

# Copy WAR file into Tomcat webapps
COPY target/mahesh-shopping.war $CATALINA_HOME/webapps/mahesh-shopping.war

# Expose Tomcat port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
    CMD curl -f http://localhost:8080/mahesh-shopping/ || exit 1

# Start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
