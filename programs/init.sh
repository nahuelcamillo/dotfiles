# Post-Installation commands

kwriteconfig5 --file startkderc --group General --key systemdBoot false

# Input (fusuma mouse gestures)
sudo gpasswd -a $USER input
newgrp input

mkdir -p ~/.config/fusuma        # Create config directory
