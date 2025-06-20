# aplazo-oauth2 Example App

This folder contains scripts and configuration files to demonstrate and test OAuth 2.0 flows using ORY Hydra. It provides a quick way to initialize credentials, start an example app, and reset the environment.

## Files

- **hydra-clients.json**: Stores OAuth 2.0 client credentials for both `client_credentials` and `authorization_code` flows.
- **init-credentials.sh**: Initializes the OAuth 2.0 client credentials and writes them to `hydra-clients.json`.
- **start-example-app.sh**: Starts the example web application for the OAuth 2.0 Authorization Code Flow. If `hydra-clients.json` does not exist, it will automatically run `init-credentials.sh`.
- **reset.sh**: (Assumed) Resets the environment to a clean state.
- **start.sh**: (Assumed) Starts the main application or supporting services.

## Prerequisites

- [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) installed
- [jq](https://stedolan.github.io/jq/) installed for JSON parsing
- ORY Hydra running (typically via Docker Compose)

## Usage

### 1. Start All Services

To start all services (Hydra, example app, etc):

```sh
./start.sh
```

### 2. Initialize Credentials

If you need to (re)generate OAuth 2.0 client credentials, run:

```sh
./init-credentials.sh
```

This will create or overwrite `hydra-clients.json` with new credentials.

### 3. Start the Example App

To start the example OAuth 2.0 Authorization Code Flow app:

```sh
./start-example-app.sh
```

- If `hydra-clients.json` does not exist, it will be created automatically.
- The script will start the example app and connect to Hydra at `http://127.0.0.1:4444/`.
- The app will be available at [http://127.0.0.1:5555](http://127.0.0.1:5555).

### 4. Reset the Environment

To reset the environment (e.g., clear credentials or restart services):

```sh
./reset.sh
```

## Example hydra-clients.json

```json
{
  "client_credentials": {
    "client_id": "6d096c8c-6ebc-4ffb-a960-f85205be58e7",
    "client_secret": "7v7H_GXNgz41sUzn8dkfe9d0mB"
  },
  "authorization_code": {
    "client_id": "9b380706-16d2-4774-88ad-895bc685b5d9",
    "client_secret": "edfMsbScHWYPdFoeip48dJVa~9"
  }
}
```

## Notes

- Make sure Docker and jq are installed and available in your PATH.
- The scripts assume you are running from the project root directory.
- For more details on ORY Hydra, see the [official documentation](https://www.ory.sh/hydra/docs/).
