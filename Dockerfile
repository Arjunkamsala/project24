# ================================
# Mahesh Shopping - Custom Dockerfile
# Base: Amazon Corretto 11 + Tomcat 9
# ================================

FROM amazoncorretto:11

LABEL maintainer="Mahesh Shopping"
LABEL description="Mahesh Shopping TShirt App on Tomcat"

# Environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto
ENV CATALINA_HOME=/opt/tomcat
ENV TOMCAT_VERSION=9.0.85
ENV PATH=$JAVA_HOME/bin:$CATALINA_HOME/bin:$PATH

# Install required tools (FIX: added gzip)
RUN yum update -y && \
    yum install -y curl wget tar gzip && \
    yum clean all

# Verify Java
RUN java -version

# Download and install Tomcat
RUN mkdir -p $CATALINA_HOME && \
    wget -q https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    -O /tmp/tomcat.tar.gz && \
    tar -xzf /tmp/tomcat.tar.gz -C $CATALINA_HOME --strip-components=1 && \
    rm -f /tmp/tomcat.tar.gz

# Remove default Tomcat applications
RUN rm -rf $CATALINA_HOME/webapps/*

# Copy WAR file
COPY target/mahesh-shopping.war $CATALINA_HOME/webapps/mahesh-shopping.war

# Set working directory
WORKDIR $CATALINA_HOME

# Expose Tomcat port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
 CMD curl -f http://localhost:8080/mahesh-shopping/ || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]
