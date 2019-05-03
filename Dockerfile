# Use a minimal image as parent
FROM openjdk:8-jdk-alpine

# Environment variables
ENV TOMCAT_MAJOR=9 \
    TOMCAT_VERSION=9.0.1 \
    CATALINA_HOME=/opt/tomcat

# init
RUN apk -U upgrade --update && \
    apk add curl && \
    apk add ttf-dejavu && \
    apk add iperf3 && \
    apk add bash && \
    apk add socat
  
RUN mkdir -p /opt

# install tomcat
RUN curl -jkSL -o /tmp/apache-tomcat.tar.gz http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    gunzip /tmp/apache-tomcat.tar.gz && \
    tar -C /opt -xf /tmp/apache-tomcat.tar && \
    ln -s /opt/apache-tomcat-$TOMCAT_VERSION $CATALINA_HOME



RUN apk add --no-cache --update libgcc libstdc++
COPY dist/usr/sbin/zerotier-one /zerotier-one
RUN chmod 0755 /zerotier-one && ln -sf /zerotier-one /zerotier-cli && ln -sf /zerotier-one /zerotier-idtool && mkdir -p /var/lib/zerotier-one




# cleanup
RUN apk del curl && \
    rm -rf /tmp/* /var/cache/apk/*

EXPOSE 8080
EXPOSE 5201

COPY startup.sh /opt/startup.sh
COPY url-shortener.war $CATALINA_HOME/webapps

ENTRYPOINT /opt/startup.sh

WORKDIR $CATALINA_HOME
