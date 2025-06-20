#!/bin/bash

set -e

# Check if hydra-clients.json exists, if not, run init-credentials.sh
if [ ! -f hydra-clients.json ]; then
  echo "hydra-clients.json not found. Running ./init-credentials.sh..."
  ./init-credentials.sh
fi

# Load client credentials from hydra-clients.json
code_client_id=$(jq -r '.authorization_code.client_id' hydra-clients.json)
code_client_secret=$(jq -r '.authorization_code.client_secret' hydra-clients.json)

cd ..

# Start the example web application for OAuth 2.0 Authorization Code Flow
echo "Starting example web application on http://127.0.0.1:5555 ..."
docker compose -f quickstart.yml exec hydra \
    hydra perform authorization-code \
    --client-id "$code_client_id" \
    --client-secret "$code_client_secret" \
    --endpoint http://127.0.0.1:4444/ \
    --port 5555 \
    --scope openid --scope offline
