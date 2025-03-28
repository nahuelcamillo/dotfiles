# Backup and Restore QEMU/KVM Virtual Machines on Arch Linux

This guide documents how to back up and restore QEMU/KVM virtual machines using `virsh`, `rsync`, and optionally `scp`. It includes handling permissions and SSH configuration for root access.

---

## 🧠 Assumptions
- VM name: `win10`
- Disk file: `/var/lib/libvirt/images/win10.qcow2`
- ISO file: `/var/lib/libvirt/images/Win10_22H2_English_x64v1.iso`
- Old machine IP: `192.168.0.173`
- User: `nahuel`

---

## 🛠️ Backing Up the VM (on old machine)

```bash
sudo virsh dumpxml win10 > /var/lib/libvirt/images/win10.xml

mkdir -p /var/lib/libvirt/images/vm-backup

sudo mv /var/lib/libvirt/images/win10.qcow2 /var/lib/libvirt/images/vm-backup/
sudo cp /var/lib/libvirt/images/win10.xml /var/lib/libvirt/images/vm-backup/
sudo cp /var/lib/libvirt/images/Win10_22H2_English_x64v1.iso /var/lib/libvirt/images/vm-backup/
```

---

## 🛜 Transferring the VM to the new machine

### ✅ Recommended: Using `rsync` with root over SSH

```bash
rsync -avhP -e "ssh -T" root@192.168.0.173:/var/lib/libvirt/images/vm-backup/ ~/vm-backup/
```

> This ensures permissions issues won't block the transfer of `.qcow2` files.

### ⚠️ If root login is not enabled via SSH

Edit `/etc/ssh/sshd_config` on the old machine:

```bash
PermitRootLogin yes
```

Then restart SSH:

```bash
sudo systemctl restart sshd
```

**Remember to disable it again after the transfer if needed.**

---

## ✅ Restoring the VM (on new machine)

```bash
sudo mv ~/vm-backup/win10.qcow2 /var/lib/libvirt/images/
sudo mv ~/vm-backup/Win10_22H2_English_x64v1.iso /var/lib/libvirt/images/
sudo virsh define ~/vm-backup/win10.xml
```

Check VM is restored:

```bash
virsh list --all
```

You can now open `virt-manager` and start your VM.

---

## 🧩 Optional: Backup & Restore Scripts
- `backup-vm.sh`: Automates dumping, copying, and compressing VM data
- `restore-vm.sh`: Automates extracting and restoring the VM safely, checking if it already exists

Add both to your dotfiles or backup automation routines.

---

## 🧼 Clean Up (optional)

```bash
rm -rf ~/vm-backup
```

---

Let this file be your go-to reference when backing up or restoring VMs in future setups 💾

