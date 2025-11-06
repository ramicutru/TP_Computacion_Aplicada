#!/bin/bash

if [[ "$1" == "-help" ]]; then
echo "========================="
echo "Scripts de Backup - Ayuda"
echo "========================="
echo "Uso: $0 ORIGEN DESTINO"
echo "Ejemplo: $0 /var/log  /backup_dir"
echo ""
echo "Descripción:"
echo "Este script genera un archivo comprimito (.tar.gz)"
echo "del directorio ORIGEN y lo guarda en DESTINO."
echo "El nombre del backup incluye la fecha en formato YYYYMMDD"
echo ""
echo "Opciones:"
echo" -help Muestra esta ayuda y termina"
echo ""
exit 0
fi


if [[ $# -ne 2 ]]; then
  echo "Uso: $0 ORIGEN DESTINO"
  echo "Ejemplo: $0 /var/log  /backup_dir"
  exit 1
fi

ORIGEN="$1"
DESTINO="$2"


FECHA=$(date +%Y%m%d)
BASE="$(basename "$ORIGEN")"
ARCHIVO="${BASE}_bkp_${FECHA}.tar.gz"

if [[ ! -d "$ORIGEN" || ! -r "$ORIGEN" ]]; then
echo "Error; ORIGEN no existe/no es directorio o no es legible : $ORIGNEN"
exit 2
fi

if [[ ! -d "$DESTINO" || ! -w "$DESTINO" ]]; then
echo "Error; DESTINO no existe/no es directorio o no es escribible: $DESTINO"
exit 3
fi


tar -czf "${DESTINO}/${ARCHIVO}" -C "$(dirname "$ORIGEN")" "$BASE"

echo "Generando: "${DESTINO}/${ARCHIVO}""
