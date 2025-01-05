FROM openjdk:11-jdk

RUN apt-get update && apt-get install -y git curl zip

RUN curl -s https://get.sdkman.io | bash -s -- && \
    echo 'source $HOME/.sdkman/bin/sdkman-init.sh' >> ~/.bashrc && \
    bash -c "source ~/.bashrc && sdk install gradle"

WORKDIR /app


ARG REPO_URL
RUN git clone ${REPO_URL} /app


WORKDIR /app


RUN ./gradlew build


RUN ./gradlew checkstyleMain

VOLUME /report
RUN cp build/reports/checkstyle/main.html /report/

CMD tail -f /dev/null

