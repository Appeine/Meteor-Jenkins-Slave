FROM ubuntu:trusty
MAINTAINER Quint Stoffers <quint@appeine.com>

RUN apt-get update && apt-get -y install \
    default-jre-headless \
    build-essential \
    git \
    curl \
    openssh-server \
    npm

RUN ln -s /usr/bin/nodejs /usr/bin/node && npm install velocity-cli -g

# Install Meteor
RUN curl -sL https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh

# Add user jenkins
RUN adduser --quiet jenkins && echo "jenkins:jenkins" | chpasswd

# Configure SSH
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
