#!/bin/bash

set -e

RUNNING_GOGS_CONTAINER=$(docker ps --filter "name=git-repo_\d" --format "{{ .Names }}")

if [[ -z "${RUNNING_GOGS_CONTAINER}" ]]; then
    echo "=== no running gogs container match the pattern git-repo_"
    exit 1
fi;

docker exec \
       -u git \
       -e USER=git \
       ${RUNNING_GOGS_CONTAINER} \
       ./gogs admin create-user \
            --name=gogs \
            --password=password.123 \
            --email=gogs@email.com \
            --admin=true
echo "=== default gogs user (username: gogs, password: password.123) created in container ${RUNNING_GOGS_CONTAINER}"
