
FROM openjdk:11-jdk


RUN apt-get update && apt-get install -y git curl zip


ENV REPO_URL=https://github.com/Maryam-Asad19/jabref-checkstyle-docker.git


WORKDIR /app


RUN git clone ${REPO_URL} /app


WORKDIR /app


RUN curl -s https://get.sdkman.io | bash -s -- && \
    echo '. $HOME/.sdkman/bin/sdkman-init.sh' >> ~/.bashrc && \
    . $HOME/.sdkman/bin/sdkman-init.sh && \
    sdk install gradle



CMD ["gradle", "build"]


