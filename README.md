# docker-builder-maven-node-python

This docker image provides basic set of build tools for Java based Web development stacks: java, maven, node, python, git

* https://hub.docker.com/r/bwajtr/docker-npm-maven/
* https://github.com/bwajtr/docker-npm-maven

## Introduction

This project goal is to create a docker image with the following build tools included:

* Eclipse Temurin JDK 17.0.6
* Apache Maven 3.8.7
* npm 9.3.1 && nodejs v18.14.1
* Python 3.10.6
* git 2.34.1
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
