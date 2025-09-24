#!/bin/bash
# Backup de la base de datos PostgreSQL del contenedor Docker
date_str=$(date +"%Y%m%d_%H%M%S")
backup_dir="$(dirname "$0")/db_backups"
mkdir -p "$backup_dir"

# Variables de conexión
CONTAINER="SIBNE_db"
DB_USER="sibne"
DB_NAME="sibne"
DB_PASSWORD="D3vel0p3rM0deP4SS"

# Ejecutar el backup
export PGPASSWORD="$DB_PASSWORD"
docker exec $CONTAINER pg_dump -U $DB_USER $DB_NAME > "$backup_dir/backup_sibne_${date_str}.sql"
unset PGPASSWORD

echo "Backup realizado en $backup_dir/backup_sibne_${date_str}.sql"
