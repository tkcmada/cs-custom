FROM codercom/code-server:latest

RUN sudo apt update
RUN sudo apt-get -y install openjdk-11-jdk maven

RUN sudo bash -c '\
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: coder\ngroup: coder\n" > /etc/fixuid/config.yml'

RUN sudo apt-get -y install python3-pip
RUN sudo pip3 install boto3
RUN sudo pip3 install awscli

RUN code-server --install-extension vscjava.vscode-java-pack

ENTRYPOINT ["fixuid", "dumb-init", "code-server", "--host", "0.0.0.0"]
