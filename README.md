# Ambari Build and Test Sandbox

### Components included:
- Java 1.8.0
- Maven 3.5.2
- Python 2, 3 with debugger installed (currently only for python 2)

### Build container manually:
- docker build sandbox -t ambari-build-sandbox (https://hub.docker.com/r/reishin/ambari-build-sandbox/)

### Pull from docker hub:
- docker pull reishin/ambari-build-sandbox 

### How to use:
- Full isolation: docker run --name sandbox --rm -it reishin/ambari-build-sandbox
- Keep container running: docker run --name sandbox -d -t reishin/ambari-build-sandbox ; docker exec -it sandbox bash

Allow maven cache to stay across different containers:  -v /cache/dir/.m2:/root/.m2


Ambari repo downloading: git clone https://github.com/apache/ambari.git /root/ambari
  


### Useful URL's: 
- Ambari Development - https://cwiki.apache.org/confluence/display/AMBARI/Ambari+Development
- Development in Docker - https://cwiki.apache.org/confluence/display/AMBARI/Development+in+Docker



### Please note: 
  By downloading this container your are agree on Oracle Binary Code License Agreement (http://www.oracle.com/technetwork/java/javase/terms/license/index.html)
  
  Respective flag located at ${JAVA_ROOT_DIR}/accepted-oracle-license-v1-1