#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER docker;
    CREATE DATABASE cybertek;
    GRANT ALL PRIVILEGES ON DATABASE cybertek TO docker;
    GRANT ALL PRIVILEGES ON DATABASE cybertek TO postgres;
    CREATE DATABASE my_project_test;
    GRANT ALL PRIVILEGES ON DATABASE my_project_test TO docker;
EOSQL
