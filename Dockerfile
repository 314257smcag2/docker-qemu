FROM ubuntu:20.04
MAINTAINER Doro Wu <fcwu.tw@gmail.com>

ENV privileged=true
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN apt-get update \
    && apt-get install -y --force-yes --no-install-recommends qemu-kvm \
        supervisor qemu-utils wget net-tools curl iproute2 bridge-utils dnsmasq\
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /etc/qemu
RUN touch /etc/qemu/bridge.conf
RUN chmod u+r /etc/qemu/bridge.conf

ADD startup.sh /
ADD noVNC /noVNC/

EXPOSE 5900
EXPOSE 6080

ENV VM_RAM 2048
ENV VM_DISK_IMAGE_SIZE 10G
ENV VM_DISK_IMAGE /data/disk-image
ENV VM_DISK_IMAGE_CREATE_IF_NOT_EXIST 1
#ENV ISO Porteus-CINNAMON-v5.0-x86_64.iso
#ENV ISO_FORCE_DOWNLOAD 1
ENV NETWORK bridge
ENV REMOTE_ACCESS vnc
VOLUME /data
ENTRYPOINT ["/startup.sh"]
