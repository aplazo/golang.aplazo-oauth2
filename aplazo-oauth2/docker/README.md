# ORY Hydra Deployment Guide for DevOps

This document describes how to deploy the ORY Hydra service. The file `docker.yml` is provided as a reference for configuration and environment variables.

## Docker Image
- **Image:** `oryd/hydra:v2.3.0`

## Endpoints to Expose (Public Port)
The following endpoints must be exposed via the public port (default: 4444):
- `/.well-known/jwks.json`
- `/.well-known/openid-configuration`
- `/oauth2/auth`
- `/oauth2/token`
- `/oauth2/revoke`
- `/oauth2/fallbacks/consent`
- `/oauth2/fallbacks/error`
- `/oauth2/sessions/logout`
- `/userinfo`

> **Note:** The admin port (4445) must remain private and only accessible via the Aplazo VPN.

## API Gateway & Domains
This service must have a dedicated API gateway with the following domains:
- **Production:** `account.aplazo.mx`
- **Staging:** `account.aplazo.net`

## Environment Variables
Environment variables are defined in `.env.example`. The DevOps team must provide at least:
- **DSN**: PostgreSQL connection string in the format:
  ```
  postgresql://<user>:<pass>@<host>/<db_name>?search_path=oauth
  ```

The rest of the variables can be set after the initial deployment.

## Healthcheck
The service health is checked using the following endpoint on the admin port (4445):
- `GET http://127.0.0.1:4445/health/ready`

The healthcheck in `docker.yml` is configured as:
```yaml
healthcheck:
  test: ["CMD", "wget", "--spider", "-q", "http://127.0.0.1:4445/health/ready"]
  interval: 10s
  timeout: 5s
  retries: 5
  start_period: 10s
```

## Example Service Configuration (Reference)
```yaml
services:
  hydra:
    image: oryd/hydra:v2.3.0
    ports:
      - 4444:4444 # Public port
      - 4445:4445 # Admin port (private, VPN only)
    env_file:
      - .env
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "wget", "--spider", "-q", "http://127.0.0.1:4445/health/ready"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 10s
```

---
For any questions or further configuration, please refer to the official [ORY Hydra documentation](https://www.ory.sh/hydra/docs/).
