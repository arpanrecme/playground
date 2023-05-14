#!/bin/bash

mvn dependency:resolve
mvn dependency:resolve-plugins
mvn dependency:sources -Dclassifier=javadoc
mvn dependency:sources
mvn clean
mvn compile -DskipTests=true
mvn package -DskipTests=true
mvn install -DskipTests=true
mvn site -DskipTests=true

mvn spring-boot:run
