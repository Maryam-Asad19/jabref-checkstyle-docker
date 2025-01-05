FROM openjdk:11-jdk

RUN apt-get update && \
    apt-get install -y git curl

RUN curl -s https://get.sdkman.io | bash && \
    source "$HOME/.sdkman/bin/sdkman-init.sh" && \
    sdk install gradle

WORKDIR /app

ARG REPO_URL
RUN git clone $REPO_URL .

RUN gradle build

RUN gradle checkstyleMain

RUN mkdir -p /app/report && \
    cp build/reports/checkstyle/main.html /app/report/checkstyle_report.html

CMD ["gradle", "run"]
