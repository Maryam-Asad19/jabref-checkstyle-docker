FROM openjdk:11-jdk

RUN apt-get update && apt-get install -y git curl zip bash

WORKDIR /app

# Clone the repository
RUN git clone https://github.com/Maryam-Asad19/jabref-checkstyle-docker.git /app

WORKDIR /app

# Install SDKMAN and Gradle
RUN curl -s https://get.sdkman.io | bash -s -- \
    && echo "source $HOME/.sdkman/bin/sdkman-init.sh" >> /root/.bashrc \
    && /bin/bash -c "source /root/.bashrc && sdk install gradle"




