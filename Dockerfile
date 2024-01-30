FROM eclipse-temurin:17.0.10_7-jdk-focal

RUN apt-get update \
  && apt-get install -y ca-certificates openssh-client curl git --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

## START of maven installation inspired by https://github.com/carlossg/docker-maven

# common for all images
ENV MAVEN_HOME /usr/share/maven

COPY --from=maven:3.9.6-eclipse-temurin-11 ${MAVEN_HOME} ${MAVEN_HOME}
COPY --from=maven:3.9.6-eclipse-temurin-11 /usr/local/bin/mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY --from=maven:3.9.6-eclipse-temurin-11 /usr/share/maven/ref/settings-docker.xml /usr/share/maven/ref/settings-docker.xml

RUN ln -s ${MAVEN_HOME}/bin/mvn /usr/bin/mvn

ARG MAVEN_VERSION=3.9.6
ARG USER_HOME_DIR="/root"
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

## START install python

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y python3 python3-dev python-dev-is-python3 python3-pip build-essential libssl-dev libffi-dev --no-install-recommends \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*  

## START install node

RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh \
  && bash nodesource_setup.sh \
  && apt-get install -y nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*  

## Set java random sounrce to urandom to prevent blocking SecureRandom calls, which could hang the jvm in Docker
## Inspired by https://stackoverflow.com/a/52889017/1237636

RUN sed -i.bak \
  -e "s/securerandom.source=file:\/dev\/random/securerandom.source=file:\/dev\/urandom/g" \
  -e "s/securerandom.strongAlgorithms=NativePRNGBlocking/securerandom.strongAlgorithms=NativePRNG/g" \
  $JAVA_HOME/conf/security/java.security  