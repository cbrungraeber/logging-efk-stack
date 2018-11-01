#!/bin/bash
diff -Naur --exclude=".git" ./tomcat-slf4j-logback ./tomcat-slf4j-logback-changed  > ./patch/tomcat.patch
