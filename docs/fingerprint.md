# Fingerprint Authentication on ArcoLinux (Lenovo X1 Extreme + SDDM + i3)

This guide documents the steps required to enable fingerprint reader functionality on a Lenovo X1 Extreme running ArcoLinux with SDDM and i3 as the window manager.

---

## 1. Identify the fingerprint sensor

```bash
lsusb
```

Example of relevant output:
```
Bus 001 Device 003: ID 06cb:00bd Synaptics, Inc. Prometheus MIS Touch Fingerprint Reader
```

---

## 2. Install required dependencies

### 2.1 `fwupd` (optional, to check for available firmware)
```bash
sudo pacman -S fwupd
sudo fwupdmgr refresh
sudo fwupdmgr get-devices
```

### 2.2 Install driver from AUR
```bash
yay -S libfprint-2-tod1-synatudor-git
```
> Note: if installation fails due to GPG signature error, edit the `PKGBUILD`, remove `?signed` from the URL, delete any `validpgpkeys` line, and build with `makepkg -si`.

---

## 3. Install and configure `fprintd`
```bash
sudo pacman -S fprintd
fprintd-enroll
```

Follow the on-screen instructions to register your fingerprint.

---

## 4. Enable fingerprint for sudo

Edit the PAM file:
```bash
sudo nano /etc/pam.d/sudo
```
Add at the top:
```text
auth    sufficient    pam_fprintd.so
```

Test with:
```bash
sudo ls
```

---

## 5. Enable fingerprint for login (SDDM)

Edit the PAM file:
```bash
sudo nano /etc/pam.d/sddm
```
Add at the top:
```text
auth    sufficient    pam_fprintd.so
```

Reboot to test:
```bash
reboot
```

---

## 6. Enable fingerprint for screen lock with `betterlockscreen`

Create the file if it doesn't exist:
```bash
sudo nano /etc/pam.d/i3lock
```
Suggested content:
```text
#%PAM-1.0
auth    sufficient    pam_fprintd.so
auth    include        system-auth
account include        system-auth
password include       system-auth
session include        system-auth
```

Test with:
```bash
betterlockscreen -l
```

> Note: `i3lock` requires pressing Enter after a successful fingerprint scan. This behavior cannot be avoided in the standard version.

---

## Final state
- [x] Fingerprint for `sudo`
- [x] Fingerprint for login (SDDM)
- [x] Fingerprint for screen unlock (`betterlockscreen`)
- [ ] Auto-unlock without Enter (not supported by `i3lock`)

---

## Optional for future improvement
- Explore `greetd` for automatic fingerprint-based login
- Replace `i3lock` with `swaylock-effects` or another biometric-friendly locker

