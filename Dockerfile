FROM centos:6
MAINTAINER Dmitry Romanov "dmitry.romanov85@gmail.com"

RUN yum -y install epel-release && \
    yum -y clean all && \
    yum -y install git && \
    yum -y install ansible

COPY ansible-pull /var/lib/ansible/pull
