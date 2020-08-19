#!/bin/bash

DATE=$(date +%s)

docker build -t armory/gcloud-auth-helper:${DATE} .

docker push armory/gcloud-auth-helper:${DATE}
