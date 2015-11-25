FROM java:8u45-jdk
MAINTAINER Quint Stoffers <quint@appeine.com>

ENV JENKINS_SWARM_VERSION 2.0
ENV HOME /home/jenkins-slave

RUN apt-get update && apt-get -y install \
    net-tools \
    git \
    curl \
    npm

# Install Meteor
RUN curl -sL https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh

# Install Velocity CLI
RUN ln -s /usr/bin/nodejs /usr/bin/node && npm install velocity-cli -g

RUN useradd -c "Jenkins Slave user" -d $HOME -m jenkins-slave
RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar \
  && chmod 755 /usr/share/jenkins

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

USER jenkins-slave
VOLUME /home/jenkins-slave

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
