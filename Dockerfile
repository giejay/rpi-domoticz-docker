#
# Dockerfile for Rpi-Domoticz
#
# Based on version by LBTM
#
# Base image.
FROM resin/rpi-raspbian:jessie-20161026

MAINTAINER Florian Chauveau

# Install Domoticz from sources.
RUN \
  apt-get update && \
  apt-get install -y cmake apt-utils build-essential netcat lua5.2 && \
  apt-get install -y libboost-dev libboost-thread-dev libboost-system-dev libsqlite3-dev subversion curl libcurl4-openssl-dev libusb-dev zlib1g-dev && \
  apt-get install -y iputils-ping python3-pip python3-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev libjpeg8-dev && \
  pip3 install python-mirobo && \
  apt-get clean && \
  apt-get autoclean && \
  apt-get install wget && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose port.
EXPOSE 8080

RUN mkdir -p /home/pi/domoticz && \
    wget https://releases.domoticz.com/releases/release/domoticz_linux_armv7l.tgz && \
    tar -xvzf domoticz_linux_armv7l.tgz -C /home/pi/domoticz

CMD ["/home/pi/domoticz/domoticz", "-www", "8080"]
