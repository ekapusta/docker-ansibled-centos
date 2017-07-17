FROM centos:7
MAINTAINER Dmitry Romanov "dmitry.romanov85@gmail.com"

RUN yum install -y initscripts

ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum -y install epel-release && \
    yum -y clean all && \
    yum -y install git && \
    yum -y install zsh && \
    yum -y install ansible

COPY ansible-pull /var/lib/ansible/pull
COPY useradd /etc/default/useradd

RUN chsh -s /bin/zsh

COPY ansible-environment.service /etc/systemd/system/ansible-environment.service
RUN systemctl enable ansible-environment.service

COPY ansible-pull.service /etc/systemd/system/ansible-pull.service
RUN systemctl enable ansible-pull.service

CMD /usr/sbin/init
