#!/bin/bash

set -e

if [[ "$#" -lt 1 ]]; then
    echo "=== Repo name is required"
    echo "=== Usage: $0 repo-name-1 repo-name-2"
    exit 1
fi;

SCRIPT_DIR=$(cd $(dirname $0); pwd)

source ${SCRIPT_DIR}/_read_user_credentials.sh

echo

TOKEN=$(source ${SCRIPT_DIR}/generate-token.sh "" | tr -d "\n")

for REPO_NAME in "$@"
do
    EXISTING_REPO=$(curl -H "Authorization: token ${TOKEN}" \
                         -s \
                         http://localhost:3000/api/v1/user/repos | \
                         jq '.[] | select(.name == "'${REPO_NAME}'")')

    if [[ -z ${EXISTING_REPO} ]]; then
        curl -H 'Accept:application/json' \
            -H 'Content-Type:application/json' \
            -H "Authorization: token ${TOKEN}" \
            -d '{"name":"'${REPO_NAME}'"}' \
            -X POST \
            http://localhost:3000/api/v1/user/repos

        echo
        echo "== ${REPO_NAME} created"
    else
        echo "=== ${REPO_NAME} exists"
    fi
done
