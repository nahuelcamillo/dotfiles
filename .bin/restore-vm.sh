#!/bin/bash

# Configuración
BACKUP_ARCHIVE="$1"
DEST_DIR="/var/lib/libvirt/images"
TMP_DIR="/tmp/restore-vm"

# Verificación de argumentos
if [[ -z "$BACKUP_ARCHIVE" ]]; then
  echo "❗ Uso: $0 /ruta/al/backup.tar.gz"
  exit 1
fi

# Crear carpeta temporal
mkdir -p "$TMP_DIR"

echo "🗜️ Descomprimiendo backup..."
tar -xzvf "$BACKUP_ARCHIVE" -C "$TMP_DIR"

# Obtener nombre de la VM desde el archivo XML
VM_XML=$(find "$TMP_DIR" -name "*.xml" | head -n1)
VM_NAME=$(basename "$VM_XML" .xml)

# Verificar si la VM ya existe
if sudo virsh list --all | grep -q "\b$VM_NAME\b"; then
  echo "⚠️ La VM '$VM_NAME' ya está definida. Abortando para evitar conflictos."
  exit 1
fi

echo "📂 Restaurando disco y ISO..."
sudo cp "$TMP_DIR/$VM_NAME.qcow2" "$DEST_DIR/"
sudo cp "$TMP_DIR/"*.iso "$DEST_DIR/" 2>/dev/null

echo "🔧 Restaurando definición de VM..."
sudo virsh define "$VM_XML"

echo "✅ Restauración completada. VM '$VM_NAME' definida y disco copiado."

# Limpieza (opcional)
# rm -rf "$TMP_DIR"
