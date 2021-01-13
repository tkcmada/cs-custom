FROM codercom/code-server:latest

RUN sudo apt update
RUN sudo apt-get -y install openjdk-11-jdk maven

ENTRYPOINT ["/usr/bin/entrypoint.sh" "--no-auth" "--bind-addr" "0.0.0.0:8080" "."]
#ENTRYPOINT /bin/bash
