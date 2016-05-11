FROM debian:latest
MAINTAINER Edward Makhlin <edward@denga.pro>

# Install packages
RUN apt-get update && \
    apt-get -y install openssh-server pwgen python apt-utils && \
    rm -rf /var/lib/apt && \
    mkdir -p /var/run/sshd && \
sed -i -e "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" -e "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

ADD run.sh /run.sh
RUN chmod +x /*.sh && echo "root:docker.io" | chpasswd

EXPOSE 22
CMD ["/run.sh"] 
