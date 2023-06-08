FROM debian:bullseye

RUN apt update && apt install -y wget unzip openjdk-17-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/
ENV PATH=$PATH:$JAVA_HOME/bin


RUN cd /tmp
RUN wget -O gradle-8.1.1-bin.zip https://services.gradle.org/distributions/gradle-8.1.1-bin.zip && unzip gradle-*.zip
RUN mkdir /opt/gradle && cp -pr gradle-*/* /opt/gradle

ENV PATH=/opt/gradle/bin:${PATH}

RUN gradle -v

COPY . /app
WORKDIR /app

RUN gradle build