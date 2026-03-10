# ================================
# Mahesh Shopping - Custom Dockerfile
# Base: Amazon Corretto 11 + Tomcat 9
# ================================

FROM amazoncorretto:11

LABEL maintainer="Mahesh Shopping"
LABEL description="Mahesh Shopping TShirt App on Tomcat"

# ✅ FIXED - Correct JAVA_HOME for amazoncorretto:11
ENV JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto
ENV CATALINA_HOME=/opt/tomcat
ENV PATH=$CATALINA_HOME/bin:$JAVA_HOME/bin:$PATH
ENV TOMCAT_VERSION=9.0.85

# Install required tools
RUN yum update -y && \
    yum install -y curl wget tar && \
    yum clean all

# ✅ Verify Java is working inside container during build
RUN java -version && echo "JAVA_HOME=$JAVA_HOME"

# Download and install Tomcat
RUN mkdir -p /opt/tomcat && \
    wget -q https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    -O /tmp/tomcat.tar.gz && \
    tar -xzf /tmp/tomcat.tar.gz -C /opt/tomcat --strip-components=1 && \
    rm /tmp/tomcat.tar.gz

# Remove default Tomcat apps
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
