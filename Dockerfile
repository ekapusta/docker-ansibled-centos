FROM centos:6
MAINTAINER Dmitry Romanov "dmitry.romanov85@gmail.com"

RUN yum -y install epel-release && \
    yum -y clean all && \
    yum -y install git && \
    yum -y install zsh && \
    yum -y install ansible

COPY ansible-pull /var/lib/ansible/pull
COPY useradd /etc/default/useradd

RUN chsh -s /bin/zsh

CMD cd /var/lib/ansible/pull && ansible-playbook playbook.yml ; /bin/zsh
