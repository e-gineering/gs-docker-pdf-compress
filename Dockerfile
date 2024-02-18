FROM ubuntu:latest

RUN apt-get update && apt-get install -y ghostscript

WORKDIR /data
VOLUME /data

ENTRYPOINT ["gs"]