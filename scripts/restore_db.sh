#!/bin/bash
# Script para restaurar backup de la base de datos PostgreSQL en el contenedor Docker

# Función para mostrar ayuda
show_help() {
    echo "Uso: $0 [opciones] [archivo_backup]"
    echo ""
    echo "Opciones:"
    echo "  -h, --help              Mostrar esta ayuda"
    echo "  -l, --list              Listar backups disponibles"
    echo "  -f, --force             Forzar restauración sin confirmación"
    echo "  -c, --clean             Limpiar base de datos antes de restaurar"
    echo "  -s, --schema SCHEMA     Especificar schema de destino (default: public)"
    echo ""
    echo "Ejemplos:"
    echo "  $0                      Restaurar el backup más reciente"
    echo "  $0 backup_sibne_20251002_155833.sql"
    echo "  $0 -c -f backup_sibne_20251002_155833.sql"
    echo "  $0 -l                   Listar backups disponibles"
}

# Función para listar backups
list_backups() {
    echo "📋 Backups disponibles:"
    echo "======================="
    backup_dir="$(dirname "$0")/db_backups"
    
    if [ ! -d "$backup_dir" ]; then
        echo "❌ No existe el directorio de backups: $backup_dir"
        exit 1
    fi
    
    # Listar archivos .sql ordenados por fecha (más reciente primero)
    find "$backup_dir" -name "backup_sibne_*.sql" -type f -printf "%T@ %p\n" | sort -nr | while read timestamp file; do
        filename=$(basename "$file")
        size=$(du -h "$file" | cut -f1)
        date_str=$(date -d "@$timestamp" "+%Y-%m-%d %H:%M:%S")
        echo "  📄 $filename (${size}) - $date_str"
    done
}

# Función para obtener el backup más reciente
get_latest_backup() {
    backup_dir="$(dirname "$0")/db_backups"
    find "$backup_dir" -name "backup_sibne_*.sql" -type f -printf "%T@ %p\n" | sort -nr | head -1 | cut -d' ' -f2
}

# Función para confirmar acción
confirm_action() {
    local message="$1"
    if [ "$FORCE" = true ]; then
        return 0
    fi
    
    echo -n "$message (y/N): "
    read -r response
    case "$response" in
        [yY][eE][sS]|[yY])
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Función para limpiar base de datos
cleanup_database() {
    echo "🧹 Limpiando base de datos..."
    
    # Script para eliminar todas las tablas del schema
    cleanup_sql="
    DO \$\$ 
    DECLARE 
        r RECORD;
    BEGIN
        -- Eliminar todas las tablas del schema
        FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = '$SCHEMA') 
        LOOP
            EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(r.tablename) || ' CASCADE';
        END LOOP;
        
        -- Eliminar secuencias huérfanas
        FOR r IN (SELECT sequence_name FROM information_schema.sequences WHERE sequence_schema = '$SCHEMA')
        LOOP
            EXECUTE 'DROP SEQUENCE IF EXISTS ' || quote_ident(r.sequence_name) || ' CASCADE';
        END LOOP;
    END \$\$;
    "
    
    export PGPASSWORD="$DB_PASSWORD"
    echo "$cleanup_sql" | docker exec -i $CONTAINER psql -U $DB_USER -d $DB_NAME
    local exit_code=$?
    unset PGPASSWORD
    
    if [ $exit_code -eq 0 ]; then
        echo "✅ Base de datos limpiada correctamente"
    else
        echo "❌ Error al limpiar la base de datos"
        exit 1
    fi
}

# Función para restaurar backup
restore_backup() {
    local backup_file="$1"
    
    echo "🔄 Restaurando backup: $(basename "$backup_file")"
    echo "📍 Contenedor: $CONTAINER"
    echo "🗄️  Base de datos: $DB_NAME"
    echo "👤 Usuario: $DB_USER"
    echo "📋 Schema: $SCHEMA"
    echo ""
    
    # Verificar que el archivo existe
    if [ ! -f "$backup_file" ]; then
        echo "❌ El archivo de backup no existe: $backup_file"
        exit 1
    fi
    
    # Verificar que el contenedor está corriendo
    if ! docker ps | grep -q "$CONTAINER"; then
        echo "❌ El contenedor $CONTAINER no está corriendo"
        echo "💡 Ejecutar: docker-compose up -d"
        exit 1
    fi
    
    # Mostrar información del backup
    backup_size=$(du -h "$backup_file" | cut -f1)
    echo "📦 Tamaño del backup: $backup_size"
    
    # Confirmar restauración
    if ! confirm_action "¿Proceder con la restauración?"; then
        echo "❌ Restauración cancelada"
        exit 1
    fi
    
    # Limpiar base de datos si se solicita
    if [ "$CLEAN" = true ]; then
        cleanup_database
    fi
    
    # Ejecutar restauración
    echo "⏳ Restaurando... (esto puede tomar varios minutos)"
    start_time=$(date +%s)
    
    export PGPASSWORD="$DB_PASSWORD"
    
    # Crear schema si no existe
    docker exec $CONTAINER psql -U $DB_USER -d $DB_NAME -c "CREATE SCHEMA IF NOT EXISTS $SCHEMA;"
    
    # Restaurar el backup
    if [ "$SCHEMA" = "public" ]; then
        # Restauración directa para schema public
        cat "$backup_file" | docker exec -i $CONTAINER psql -U $DB_USER -d $DB_NAME
    else
        # Restauración con schema específico
        # Modificar el SQL para usar el schema correcto
        sed "s/public\./$SCHEMA\./g; s/SCHEMA public/SCHEMA $SCHEMA/g" "$backup_file" | \
        docker exec -i $CONTAINER psql -U $DB_USER -d $DB_NAME
    fi
    
    local exit_code=$?
    unset PGPASSWORD
    
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    
    if [ $exit_code -eq 0 ]; then
        echo ""
        echo "✅ Restauración completada exitosamente"
        echo "⏱️  Tiempo transcurrido: ${duration} segundos"
        
        # Mostrar estadísticas básicas
        export PGPASSWORD="$DB_PASSWORD"
        echo ""
        echo "📊 Estadísticas de la restauración:"
        docker exec $CONTAINER psql -U $DB_USER -d $DB_NAME -c "
        SELECT 
            schemaname,
            COUNT(*) as total_tablas
        FROM pg_tables 
        WHERE schemaname = '$SCHEMA'
        GROUP BY schemaname;
        "
        unset PGPASSWORD
        
    else
        echo ""
        echo "❌ Error durante la restauración"
        echo "💡 Revisar los logs para más detalles"
        exit 1
    fi
}

# Variables por defecto
backup_dir="$(dirname "$0")/db_backups"
CONTAINER="SIBNE_db"
DB_USER="sibne"
DB_NAME="sibne"
DB_PASSWORD="D3vel0p3rM0deP4SS"
SCHEMA="dbo"
FORCE=false
CLEAN=false
LIST=false

# Parsear argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -l|--list)
            LIST=true
            shift
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        -c|--clean)
            CLEAN=true
            shift
            ;;
        -s|--schema)
            SCHEMA="$2"
            shift 2
            ;;
        -*)
            echo "❌ Opción no reconocida: $1"
            show_help
            exit 1
            ;;
        *)
            BACKUP_FILE="$1"
            shift
            ;;
    esac
done

# Ejecutar según la opción seleccionada
if [ "$LIST" = true ]; then
    list_backups
    exit 0
fi

# Determinar archivo de backup a usar
if [ -z "$BACKUP_FILE" ]; then
    echo "🔍 Buscando el backup más reciente..."
    BACKUP_FILE=$(get_latest_backup)
    
    if [ -z "$BACKUP_FILE" ]; then
        echo "❌ No se encontraron backups en $backup_dir"
        echo "💡 Ejecutar '$0 -l' para listar backups disponibles"
        exit 1
    fi
    
    echo "📄 Usando backup más reciente: $(basename "$BACKUP_FILE")"
else
    # Si se proporciona solo el nombre del archivo, construir la ruta completa
    if [[ "$BACKUP_FILE" != /* ]]; then
        BACKUP_FILE="$backup_dir/$BACKUP_FILE"
    fi
fi

# Ejecutar restauración
restore_backup "$BACKUP_FILE"

echo ""
echo "🎉 Proceso completado - $(date)"