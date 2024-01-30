# docker-builder-maven-node-python

This docker image provides basic set of build tools for Java based Web development stacks: java, maven, node, python, git

* https://hub.docker.com/r/bwajtr/docker-builder-maven-node-python
* https://github.com/bwajtr/docker-builder-maven-node-python

## Introduction

This project goal is to create a docker image with the following build tools included:

* Eclipse Temurin JDK 17.0.10 
  * Note that java.security has been modified by setting securerandom.source=file:/dev/urandom
* Apache Maven 3.9.6
* npm 10.2.3 && nodejs v18.19.0
* Python 3.8.10
* git 2.25.1
* openssh-client (scp, ssh)

## How to use

```
docker run --rm -it bwajtr/docker-builder-maven-node-python:latest /bin/bash
```

## Example when using gitlab-ci pipelines

in you gitlab-ci.yml:

```
build:
  image: bwajtr/docker-npm-maven:latest
  stage: build
  script:
    - mvn commands
    - npm commands
    - git commands
    - python commands
    - ...
```
