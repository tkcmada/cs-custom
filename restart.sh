#/bin/bash

# Dirs and files
mkdir -p "$HOME/projects"                 # Root dir shared with Coder
mkdir -p "$HOME/.local/share/code-server" # Coder's config dir
mkdir -p "$HOME/.lego"                    # SSL certificates
mkdir -p "$HOME/.ssh"                     # SSH keys, config and known_hosts
touch "$HOME/.gitconfig"                  # Git configs

# Stop and delete the container if exists
docker stop coder2 > /dev/null 2>&1
docker rm   coder2 > /dev/null 2>&1

# Build and run
docker pull tkcmada/cs-custom
docker run \
  --name coder2 \
  --detach \
  --restart unless-stopped \
  -p 80:8080 \
  --user $(id -u):$(id -g) \
  -v $HOME/projects:/home/coder/project \
  -v $HOME/.local/share/code-server:/home/coder/.local/share/code-server \
  -v $HOME/.lego:/.lego \
  -v $HOME/.ssh:/home/coder/.ssh \
  -v $HOME/.gitconfig:/home/coder/.gitconfig \
  tkcmada/cs-custom \
    --auth=none \
    --cert="/.lego/certificates/$CODER_HOST.crt" \
    --cert-key="/.lego/certificates/$CODER_HOST.key"

#  --env SSH_AUTH_SOCK=/ssh-agent \
#  -v $SSH_AUTH_SOCK:/ssh-agent \
#  --env PASSWORD=coder \
