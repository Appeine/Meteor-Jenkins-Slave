FROM csanchez/jenkins-swarm-slave
MAINTAINER Quint Stoffers <quint@appeine.com>

RUN apt-get update && apt-get -y install \
    git \
    curl \
    npm

# Install Meteor
RUN curl -sL https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh

# Install Velocity CLI
RUN ln -s /usr/bin/nodejs /usr/bin/node && npm install velocity-cli -g
