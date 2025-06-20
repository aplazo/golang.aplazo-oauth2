#!/bin/bash

set -e

# Create OAuth 2.0 Client for client_credentials grant
echo "Creating client_credentials client..."
client=$(docker compose -f ../quickstart.yml exec hydra \
    hydra create client \
    --endpoint http://127.0.0.1:4445/ \
    --format json \
    --grant-type client_credentials)

client_id=$(echo $client | jq -r '.client_id')
client_secret=$(echo $client | jq -r '.client_secret')

echo "Performing client credentials grant..."
docker compose -f ../quickstart.yml exec hydra \
  hydra perform client-credentials \
  --endpoint http://127.0.0.1:4444/ \
  --client-id "$client_id" \
  --client-secret "$client_secret"

# Create OAuth 2.0 Client for authorization_code grant
echo "Creating authorization_code client..."
code_client=$(docker compose -f ../quickstart.yml exec hydra \
    hydra create client \
    --endpoint http://127.0.0.1:4445 \
    --grant-type authorization_code,refresh_token \
    --response-type code,id_token \
    --format json \
    --scope openid --scope offline \
    --redirect-uri http://127.0.0.1:5555/callback)

code_client_id=$(echo $code_client | jq -r '.client_id')
code_client_secret=$(echo $code_client | jq -r '.client_secret')

# Save all client variables into a JSON file
cat <<EOF > hydra-clients.json
{
  "client_credentials": {
    "client_id": "$client_id",
    "client_secret": "$client_secret"
  },
  "authorization_code": {
    "client_id": "$code_client_id",
    "client_secret": "$code_client_secret"
  }
}
EOF

echo "Client credentials saved to hydra-clients.json"
