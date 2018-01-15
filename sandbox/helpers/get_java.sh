#!/usr/bin/env bash

# how to use: get_java.sh 8u151 /tmp/my_java.rpm
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

JAVA8_DOWNLOAD_PAGE="http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html"
JAVA9_DOWNLOAD_PAGE="http://www.oracle.com/technetwork/java/javase/downloads/jdk9-downloads-3848520.html"

VER=$1
JAVA_MAJOR_VER=${VER:0:1}
DOWNLOAD_PAGE=
TYPE="tar.gz"
PLATFORM="linux x64"
CACHE_FILE="/tmp/java_down_page.html"
OUTPUT_FILE=$2

finish(){
 if [ -f ${CACHE_FILE} ]; then
   rm -f ${CACHE_FILE}
 fi
}

trap finish EXIT

if [ "x${JAVA_MAJOR_VER}" == "x8" ]; then
 DOWNLOAD_PAGE=${JAVA8_DOWNLOAD_PAGE}
elif [ "x${JAVA_MAJOR_VER}" == "x9" ]; then
 DOWNLOAD_PAGE=${JAVA9_DOWNLOAD_PAGE}
else
  echo "Supporting only Java: 8, 9"
  exit 1
fi

if [ -f ${CACHE_FILE} ]; then
 rm -f ${CACHE_FILE} 1>/dev/null 2>&1
fi

if [ -f ${OUTPUT_FILE} ]; then
 rm -f ${OUTPUT_FILE} 1>/dev/null 2>&1
fi


curl "${DOWNLOAD_PAGE}" > "${CACHE_FILE}"
if [ $? -ne 0 ]; then
  echo "Exception in downloading ${DOWNLOAD_PAGE}"
  exit 1
fi

DOWNLOAD_URL=$(python "${DIR}/get_java_parser.py" "${CACHE_FILE}" "${VER}" "${PLATFORM}" "${TYPE}")

if [ $? -ne 0 ]; then
 echo "Exception in extracting url path"
 exit 1
fi

if [ "x${OUTPUT_FILE}" == "x" ]; then
  curl -L -H "Cookie: oraclelicense=accept-securebackup-cookie" "${DOWNLOAD_URL}" -O
else
  curl -L -H "Cookie: oraclelicense=accept-securebackup-cookie" "${DOWNLOAD_URL}" -o "${OUTPUT_FILE}"
fi

if [ $? -ne 0 ]; then
 echo "Error downloading file"
 exit 1
fi