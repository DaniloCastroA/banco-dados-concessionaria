#!/usr/bin/env bash
# Cria o schema, carrega os dados e executa todos os scripts na ordem.
# Uso: DATABASE_URL=postgresql://user:pass@localhost:5432/postgres ./run.sh
set -u
DB="${DATABASE_URL:-postgresql://postgres:postgres@localhost:5432/postgres}"

psql "$DB" -c "DROP SCHEMA IF EXISTS carros CASCADE; CREATE SCHEMA carros;"

for f in sql/01_schema.sql sql/02_seed.sql sql/04_views.sql \
         sql/05_functions_procedures_triggers.sql sql/06_indexes.sql sql/03_queries.sql; do
  echo "== $f"
  psql "$DB" -c "SET search_path TO carros;" -f "$f"
done
