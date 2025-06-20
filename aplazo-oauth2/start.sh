#!/bin/bash
cd ..
docker compose -f quickstart.yml -f quickstart-postgres.yml up -d
