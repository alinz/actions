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

# This is trick I came up, as I can't figured out the way to split string only based on \n and not spaces
# I replaced spaces with very unique string, then split, then replace uniqe string with space
SPLINTER="________________"
COMMANDS="$*"
COMMANDS=${COMMANDS// /SPLINTER}
COMMANDS=$(echo "$COMMANDS" | tr "\n" "\n")

for COMMAND in $COMMANDS
do
  COMMAND=${COMMAND//SPLINTER/ }
  scp -r -o StrictHostKeyChecking=no $COMMAND
done