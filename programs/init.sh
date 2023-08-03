# Post-Installation commands

kwriteconfig5 --file startkderc --group General --key systemdBoot false

# Input (fusuma mouse gestures)
sudo gpasswd -a $USER input
newgrp input

mkdir -p ~/.config/fusuma        # Create config directory

# Related to gestures, solution to natural scrolling issue with magic trackpad 2.
# Create file
sudo nano /etc/X11/xorg.conf.d/90-magic-trackpad.conf

# Insert the following lines and uncomment

# Section "InputClass"
#     Identifier "Magic Trackpad 2"
#     MatchProduct "Apple Inc. Magic Trackpad 2"
#     Driver "libinput"
#     Option "NaturalScrolling" "true"
# EndSection

# Virtualization configs
sudo systemctl enable --now libvirtd
sudo nano /etc/libvirt/libvirtd.conf
# Uncomment line "unix_sock_group = "libvirt""
# Uncomment line "unix_sock_rw_perms = "0770""
sudo usermod -a -G libvirt $USER
sudo systemctl restart libvirtd

