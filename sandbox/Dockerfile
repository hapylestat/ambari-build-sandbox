FROM ubuntu:17.10
MAINTAINER hapy.lestat@gmail.com

# base system requirements, putting at top to avoid re-build layers
COPY helpers/get_java.sh /tmp/get_java.sh
COPY helpers/get_java_parser.py /tmp/get_java_parser.py

RUN apt-get update &&\
    apt-get install curl python python3 python-pip python3-pip git unzip -y

# Java, Maven versions
ENV JAVA_VER=8u152
ENV MVN_VERSION=3.5.2

ENV JAVA_ROOT_DIR=/usr/jdk
ENV JAVA_HOME=${JAVA_ROOT_DIR}/${JAVA_VER}
ENV DERBY_HOME=${JAVA_HOME}/db
ENV PATH=${PATH}:${JAVA_HOME}/bin:${JAVA_HOME}/db/bin:${JAVA_HOME}/jre/bin
ENV MAVEN_OPTS -Xmx2048m -XX:MaxPermSize=512m -Djava.awt.headless=true

# Java binary
RUN mkdir /usr/jdk &&\
    cd /usr/jdk &&\
    bash /tmp/get_java.sh ${JAVA_VER} jdk-${JAVA_VER}-linux-x64.tar.gz &&\
    mkdir ${JAVA_VER} &&\
    tar xf jdk-${JAVA_VER}-linux-x64.tar.gz -C ${JAVA_VER} --strip-components 1&&\
    rm -f jdk-${JAVA_VER}-linux-x64.tar.gz

# Maven binary
RUN cd /opt &&\
    curl http://archive.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz -o apache-maven-${MVN_VERSION}-bin.tar.gz &&\
    tar xf apache-maven-${MVN_VERSION}-bin.tar.gz && rm -f apache-maven-${MVN_VERSION}-bin.tar.gz &&\
    ln -s /opt/apache-maven-${MVN_VERSION}/bin/mvn /usr/bin/mvn

# building tools
RUN apt-get install rpm rpm-common rpm2cpio -y &&\
    pip install setuptools &&\
    pip3 install setuptools

# pydebug egg: https://plugins.jetbrains.com/plugin/631-python
# 173.4127—173.*: https://plugins.jetbrains.com/plugin/download?updateId=41832
RUN cd /tmp &&\
    curl -L https://plugins.jetbrains.com/plugin/download?updateId=41832 -o egg.zip &&\
    unzip egg.zip &&\
    python2 -m easy_install python/pycharm-debug.egg &&\
    #python3 -m easy_install python/pycharm-debug-py3k.egg &&\
    rm -rf /tmp/python &&\
    rm -f egg.zip


CMD ["/bin/bash"]