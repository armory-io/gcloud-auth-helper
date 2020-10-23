#!/bin/sh

set -uo pipefail

: EXEC_CREDENTIAL_PATH ${EXEC_CREDENTIAL_PATH:=/tmp/gcloud/auth_token};

_cleanup() { exec 3>&- ; exit 0 ; };
for i in TERM QUIT INT HUP EXIT; do trap '_cleanup' $i; done;

if ! test -e "$EXEC_CREDENTIAL_PATH"; then
  mkfifo "$EXEC_CREDENTIAL_PATH";
fi;
while test -p "$EXEC_CREDENTIAL_PATH"; do
  exec 3>"$EXEC_CREDENTIAL_PATH";
  rm -rf "$EXEC_CREDENTIAL_PATH" > /dev/null;
  mkfifo "$EXEC_CREDENTIAL_PATH" > /dev/null;
  echo "$(date): Generating token" >&2;
  /app/gcp-exec-creds >&3;
  exec 3>&- ;
done;

