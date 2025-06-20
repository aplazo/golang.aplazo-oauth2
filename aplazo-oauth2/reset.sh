#!/bin/bash
cd ..
docker compose -f quickstart.yml -f quickstart-postgres.yml stop
docker compose -f quickstart.yml -f quickstart-postgres.yml kill
docker compose -f quickstart.yml -f quickstart-postgres.yml rm -f -v
