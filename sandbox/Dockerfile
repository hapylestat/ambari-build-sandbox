FROM ubuntu:17.10
MAINTAINER hapy.lestat@gmail.com

ENV JAVA8_VER=8u151 JAVA8_BUILD=b12 JAVA8_DIR=1.8.0_151 JTOKEN=e758a0de34e24606bca991d704f6dcbf
ENV MVN_VERSION=3.5.2
ENV JAVA_ROOT_DIR=/usr/jdk J2SDKDIR=${JAVA_ROOT_DIR}/${JAVA8_DIR}
ENV J2REDIR=${JAVA_ROOT_DIR}/${JAVA8_DIR} JAVA_HOME=/usr/jdk/jdk${JAVA8_DIR} DERBY_HOME=/usr/jdk/jdk${JAVA8_DIR}/db JAVA7_HOME=/usr/jdk/jdk${JAVA7_DIR}
ENV PATH_J8=${PATH}:${JAVA_ROOT_DIR}/${JAVA8_DIR}/bin:${JAVA_ROOT_DIR}/jdk${JAVA8_DIR}/db/bin:${JAVA_ROOT_DIR}/jdk${JAVA8_DIR}/jre/bin
ENV PATH=${PATH_J8}


RUN apt-get update &&\
    apt-get install curl -y &&\
    mkdir /usr/jdk &&\
    cd /usr/jdk &&\
    curl -L -H "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/${JAVA8_VER}-${JAVA8_BUILD}/${JTOKEN}/jdk-${JAVA8_VER}-linux-x64.tar.gz" -o jdk-${JAVA8_VER}-linux-x64.tar.gz &&\
    tar xf jdk-${JAVA8_VER}-linux-x64.tar.gz &&\
    rm -f jdk-${JAVA8_VER}-linux-x64.tar.gz

RUN cd /opt &&\
    curl http://archive.apache.org/dist/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz -o apache-maven-${MVN_VERSION}-bin.tar.gz &&\
    tar xf apache-maven-${MVN_VERSION}-bin.tar.gz && rm -f apache-maven-${MVN_VERSION}-bin.tar.gz &&\
    ln -s /opt/apache-maven-${MVN_VERSION}/bin/mvn /usr/bin/mvn

RUN apt-get update &&\
    apt-get install rpm rpm-common rpm2cpio nodejs npm git python-pip python3-pip nodejs-dev nodejs -y &&\
    update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 &&\
    npm install -g brunch@1.7.20 &&\
    pip install setuptools &&\
    pip3 install setuptools &&\
    curl https://raw.githubusercontent.com/creationix/nvm/v0.25.0/install.sh | bash &&\
    . /root/.nvm/nvm.sh &&\
    nvm install 0.10.40 &&\
    nvm alias default 0.10.40 &&\
    rm -f /opt/apache-maven-${MVN_VERSION}/conf/settings.xml

CMD ["/bin/bash"]