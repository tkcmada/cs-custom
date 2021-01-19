FROM codercom/code-server:latest

# For best practice, see https://docs.docker.jp/engine/articles/dockerfile_best-practice.html
RUN sudo apt update \
    && sudo apt-get -y install \
        openjdk-11-jdk \
        python3-pip \
        maven \
    && sudo apt-get clean \
    && sudo rm -rf /var/lib/apt/lists/*

RUN sudo bash -c '\
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: coder\ngroup: coder\n" > /etc/fixuid/config.yml'

RUN sudo pip3 install boto3
RUN sudo pip3 install awscli

RUN code-server --install-extension vscjava.vscode-java-pack

WORKDIR /home/coder
USER coder
RUN curl https://shimada-public.s3-ap-northeast-1.amazonaws.com/q-linuxx86.zip > q-linuxx86.zip \
    && unzip q-linuxx86.zip

ENTRYPOINT ["fixuid", "dumb-init", "code-server", "--host", "0.0.0.0"]
