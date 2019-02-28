#!/usr/bin/env bash

# how to use: get_java.sh 8u151 /tmp/my_java.rpm
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

JAVA8_DOWNLOAD_PAGE="http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html"
JAVA11_DOWNLOAD_PAGE="https://www.oracle.com/technetwork/java/javase/downloads/jdk11-downloads-5066655.html"
JAVA12_DOWNLOAD_PAGE="https://download.java.net/java/GA/jdk12/33/GPL" #openjdk-12_linux-x64_bin.tar.gz

JAVA_MAJOR_VER=$1
DOWNLOAD_PAGE=
TYPE="tar.gz"
CACHE_FILE="/tmp/java_down_page.html"
OUTPUT_FILE=$2

finish(){
 if [[ -f ${CACHE_FILE} ]]; then
   rm -f ${CACHE_FILE}
 fi
}

trap finish EXIT

if [[ "x${JAVA_MAJOR_VER}" == "x8" ]]; then
 DOWNLOAD_PAGE=${JAVA8_DOWNLOAD_PAGE}
 PLATFORM="linux x64"
elif [[ "x${JAVA_MAJOR_VER}" == "x11" ]]; then
 DOWNLOAD_PAGE=${JAVA11_DOWNLOAD_PAGE}
 PLATFORM="linux"
elif [[ "x${JAVA_MAJOR_VER}" == "x12" ]]; then
 PLATFORM="linux"
 DOWNLOAD_URL="${JAVA12_DOWNLOAD_PAGE}/openjdk-${JAVA_MAJOR_VER}_${PLATFORM}-x64_bin.${TYPE}"
else
  echo "Supporting only Java: 8, 11, 12; Java 9, 10: under EOL"
  exit 1
fi

if [[ "x${JAVA_MAJOR_VER}" != "x12" ]]; then
  if [[ -f ${CACHE_FILE} ]]; then
   rm -f ${CACHE_FILE} 1>/dev/null 2>&1
  fi

  if [[ -f ${OUTPUT_FILE} ]]; then
   rm -f ${OUTPUT_FILE} 1>/dev/null 2>&1
  fi

  curl -L "${DOWNLOAD_PAGE}" -o "${CACHE_FILE}"
  if [[ $? -ne 0 ]]; then
    echo "Exception in downloading ${DOWNLOAD_PAGE}"
    exit 1
  fi

  DOWNLOAD_URL=$(python "${DIR}/get_java_parser.py" "${CACHE_FILE}" "${JAVA_MAJOR_VER}" "${PLATFORM}" "${TYPE}")
fi

if [[ $? -ne 0 ]]; then
 echo "Exception in extracting url path"
 exit 1
fi

HEADER="Cookie: oraclelicense=accept-securebackup-cookie"

if [[ "x${OUTPUT_FILE}" == "x" ]]; then
  curl -L -H "${HEADER}" "${DOWNLOAD_URL}" -O
else
  curl -L -H "${HEADER}" "${DOWNLOAD_URL}" -o "${OUTPUT_FILE}"
fi

if [[ $? -ne 0 ]]; then
 echo "JDK ${JAVA_MAJOR_VER} Download failed "
 exit 1
fi