#!/usr/bin/env bash
# Cria o schema, carrega os dados e executa todos os scripts na ordem.
#
# Uso:
#   ./run.sh                                  # usa o container "pg-carros" (docker)
#   DATABASE_URL=postgresql://... ./run.sh    # usa um PostgreSQL de sua escolha
#
# Se o cliente psql nao estiver instalado, o script usa o psql de dentro do container.
set -u

DB="${DATABASE_URL:-postgresql://postgres:postgres@localhost:5432/postgres}"
CONTAINER="${PG_CONTAINER:-pg-carros}"

if command -v psql >/dev/null 2>&1; then
  run_sql()  { psql "$DB" -v ON_ERROR_STOP=0 -c "$1"; }
  run_file() { psql "$DB" -v ON_ERROR_STOP=0 -c "SET search_path TO carros;" -f "$1"; }
elif docker ps --format '{{.Names}}' 2>/dev/null | grep -qx "$CONTAINER"; then
  echo "psql nao encontrado; usando o psql de dentro do container '$CONTAINER'."
  DB_IN="postgresql://postgres:postgres@localhost:5432/postgres"
  run_sql()  { docker exec -i "$CONTAINER" psql "$DB_IN" -v ON_ERROR_STOP=0 -c "$1"; }
  run_file() { docker exec -i "$CONTAINER" psql "$DB_IN" -v ON_ERROR_STOP=0 \
                 -c "SET search_path TO carros;" -f - < "$1"; }
else
  echo "Erro: nem o cliente psql nem o container '$CONTAINER' foram encontrados." >&2
  echo "Instale o cliente:  sudo apt-get install -y postgresql-client" >&2
  echo "Ou suba o banco:    docker run --name $CONTAINER -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres:16" >&2
  exit 1
fi


for i in $(seq 1 30); do
  run_sql "SELECT 1;" >/dev/null 2>&1 && break
  sleep 1
  [ "$i" = 30 ] && { echo "Erro: o banco nao respondeu em 30s." >&2; exit 1; }
done

run_sql "DROP SCHEMA IF EXISTS carros CASCADE; CREATE SCHEMA carros;"

for f in sql/01_schema.sql sql/02_seed.sql sql/04_views.sql \
         sql/05_functions_procedures_triggers.sql sql/06_indexes.sql sql/03_queries.sql; do
  echo
  echo "== $f"
  run_file "$f"
done

