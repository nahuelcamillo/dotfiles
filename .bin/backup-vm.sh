#!/bin/bash

# Configuración
VM_NAME="win10"
DISK_IMAGE="/var/lib/libvirt/images/win10.qcow2"
ISO_IMAGE="/var/lib/libvirt/images/Win10_22h2_English_x64v1.iso"
BACKUP_DIR="$HOME/vm-backups"
TMP_DIR="/tmp/vm-backup-$VM_NAME"

# Crear carpetas necesarias
mkdir -p "$TMP_DIR"
mkdir -p "$BACKUP_DIR"

echo "🛠️ Exportando definición de la VM..."
sudo virsh dumpxml "$VM_NAME" > "$TMP_DIR/${VM_NAME}.xml"

echo "📦 Copiando disco y ISO..."
sudo cp "$DISK_IMAGE" "$TMP_DIR/"
sudo cp "$ISO_IMAGE" "$TMP_DIR/"

echo "🗜️ Empaquetando backup..."
tar -czvf "$BACKUP_DIR/${VM_NAME}-backup-$(date +%Y%m%d).tar.gz" -C "$TMP_DIR" .

echo "✅ Backup creado en $BACKUP_DIR"

echo "🔐 Generando checksum:"
sha256sum "$BACKUP_DIR/${VM_NAME}-backup-$(date +%Y%m%d).tar.gz"

echo "🧹 Limpiando archivos temporales..."
rm -rf "$TMP_DIR"
