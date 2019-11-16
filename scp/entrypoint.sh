#!/bin/sh

set -e

SSH_PATH="$HOME/.ssh"

mkdir -p "$SSH_PATH"
touch "$SSH_PATH/known_hosts"

echo "$PRIVATE_KEY" > "$SSH_PATH/deploy_key"

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_PATH/known_hosts"
chmod 600 "$SSH_PATH/deploy_key"

eval $(ssh-agent)
ssh-add "$SSH_PATH/deploy_key"

ssh-keyscan -t rsa $HOST >> "$SSH_PATH/known_hosts"

OIFS="$IFS"
IFS='\n'
COMMANDS=$(echo "$*" | tr "\n" "\n")
IFS="$OIFS"

for COMMAND in $COMMANDS
do
  echo "scp -r -o StrictHostKeyChecking=no $COMMAND"
  scp -r -o StrictHostKeyChecking=no $COMMAND
done