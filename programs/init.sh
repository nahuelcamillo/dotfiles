# Post-Installation commands

kwriteconfig5 --file startkderc --group General --key systemdBoot false

# Input (fusuma mouse gestures)
sudo gpasswd -a $USER input
newgrp input

mkdir -p ~/.config/fusuma        # Create config directory

# Virtualization configs
sudo systemctl enable --now libvirtd
sudo nano /etc/libvirt/libvirtd.conf
# Uncomment line "unix_sock_group = "libvirt""
# Uncomment line "unix_sock_rw_perms = "0770""
sudo usermod -a -G libvirt $USER
sudo systemctl restart libvirtd






