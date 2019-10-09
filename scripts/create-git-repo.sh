#!/bin/bash

set -e

REPO_NAME=$1

if [[ -z "${REPO_NAME}" ]]; then
    echo "=== Repo name is required"
    echo "=== Usage: $0 repo-name"
    exit 1
fi;

SCRIPT_DIR=$(cd $(dirname $0); pwd)

source ${SCRIPT_DIR}/_read_user_credentials.sh

TOKEN=$(source ${SCRIPT_DIR}/generate-token.sh "" | tr -d "\n")

curl -H 'Accept:application/json' \
     -H 'Content-Type:application/json' \
     -H "Authorization: token ${TOKEN}" \
     -d '{"name":"'${REPO_NAME}'"}' \
     -X POST \
     http://localhost:3000/api/v1/user/repos
