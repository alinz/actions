#!/bin/bash

set -e

replaceAll() {
  local val=$1
  echo ${val// /_}
}

upperCase() {
  local val=$1
  echo $val | tr "[:lower:]" "[:upper:]"
}

grab() {
  local val=$1
  echo ${!val}
}

# for every argument defined in `with` section, the content can be extracted
# using this function. for example
#
# with:
#   message1: Hello
#   message2: Bye
#
# 
# grabEnv "message1" returns Hello
#
grabEnv() {
  local val=$1
  val=$(upperCase "$val")
  val=$(replaceAll "$val")
  val="INPUT_$val"
  echo $(grab "$val")
}

setupSSH() {
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
}

runSSH() {
  local VAL="$1"
  echo "ssh -o StrictHostKeyChecking=no -A -tt -p ${PORT:-22} $USER@$HOST '$VAL'"
}

runSCP() {
  # This is trick I came up, as I can't figured out the way to split string only based on \n and not spaces
  # I replaced spaces with very unique string, then split, then replace uniqe string with space
  local SPLINTER="________________"
  local COMMANDS="$1"
  COMMANDS=${COMMANDS// /SPLINTER}
  COMMANDS=$(echo "$COMMANDS" | tr "\n" "\n")

  for COMMAND in $COMMANDS
  do
    COMMAND=${COMMAND//SPLINTER/ }
    echo "scp -r -o StrictHostKeyChecking=no $COMMAND"
  done
}

# setup ssh here to prepare ssh environment
setupSSH

BEFORE=$(grabEnv "before")
echo "BEFORE: $BEFORE"
if [ -v BEFORE ]; then 
  runSSH $BEFORE
fi

UPLOAD=$(grabEnv "upload")
echo "UPLOAD: $UPLOAD"
if [ -v UPLOAD ]; then 
  runSCP $UPLOAD
fi

AFTER=$(grabEnv "after")
echo "AFTER: $AFTER"
if [ -v AFTER ]; then 
  runSSH $AFTER
fi