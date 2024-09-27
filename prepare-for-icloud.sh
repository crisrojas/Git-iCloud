#!/bin/bash

# Función para procesar cada directorio .git encontrado
process_git_dir() {
    local git_dir="$1"
    local parent_dir=$(dirname "$git_dir")
    local new_name="$parent_dir/git.nosync"
    
    echo "Procesando: $git_dir"
    
    # Renombrar .git a git.nosync
    mv "$git_dir" "$new_name"
    
    # Crear enlace simbólico
    ln -s "git.nosync" "$git_dir"
    
    echo "Procesado completado: $git_dir -> $new_name"
}

# Función principal
main() {
    # Obtener el directorio actual
    local current_dir=$(pwd)
    
    echo "Buscando directorios .git en: $current_dir"
    
    # Buscar todos los directorios .git y procesarlos
    find "$current_dir" -type d -name ".git" | while read -r git_dir; do
        process_git_dir "$git_dir"
    done
    
    echo "Proceso completado. Todos los directorios .git han sido configurados para iCloud."
}

# Ejecutar la función principal
main
