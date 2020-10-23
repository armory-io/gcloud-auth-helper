#!/bin/sh

set -uo pipefail

: EXEC_CREDENTIAL_PATH ${EXEC_CREDENTIAL_PATH:=/tmp/gcloud/auth_token};

if ! test -p "$EXEC_CREDENTIAL_PATH"; then
  mkfifo "$EXEC_CREDENTIAL_PATH";
fi;
while test -p "$EXEC_CREDENTIAL_PATH"; do
  (
    echo "$(date): Generating token" >&2;
    script -q -f -c /app/gcp-exec-creds;
  ) > "$EXEC_CREDENTIAL_PATH" ;
done;

