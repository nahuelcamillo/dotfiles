# GPU Configuration on ArcoLinux with i3

This document outlines two possible configurations for using a hybrid GPU setup (Intel + NVIDIA GTX 1650 Ti) on a laptop running ArcoLinux with i3 Window Manager.

---

## 🔹 Option 1: Use Intel GPU Only (recommended for stability and low power consumption)

### ✅ Advantages:
- Lower power usage.
- Less heat.
- Simpler configuration.
- More stable in lightweight environments like i3wm.

### ❌ Disadvantages:
- You won't benefit from the NVIDIA GPU's power for heavy tasks.

### ⚠️ When to choose this option:
- You don't play games or run heavy rendering/computing tasks.
- You prioritize system stability and overall performance.

### ⚙️ Instructions:

1. **Remove NVIDIA and nouveau drivers:**

   ```bash
   sudo pacman -Rns nvidia-open nvidia-utils nvidia-settings egl-x11 egl-wayland egl-gbm libxnvctrl xf86-video-nouveau
   ```

2. **Reboot the system:**

   ```bash
   reboot
   ```

3. **Verify that you're using Intel GPU:**

   ```bash
   glxinfo | grep "OpenGL renderer"
   ```

   It should return something like:
   ```
   OpenGL renderer string: Mesa Intel(R) UHD Graphics (CML GT2)
   ```

---

## 🔸 Option 2: Use NVIDIA GPU on-demand (when needed)

### ✅ Advantages:
- Allows you to use the NVIDIA GPU for heavy tasks (rendering, AI, etc).
- Not always active: better energy savings.

### ❌ Disadvantages:
- More complex to configure.
- Can cause conflicts if not set up properly.

### ⚠️ When to choose this option:
- You need to run CUDA-based software.
- You use tools like Blender, TensorFlow, DaVinci Resolve, etc.

### ⚙️ Instructions:

1. **Install proprietary NVIDIA drivers:**

   ```bash
   sudo pacman -S nvidia nvidia-utils nvidia-settings libxnvctrl
   ```

2. **Install PRIME support for offloading (run apps with NVIDIA manually):**

   ```bash
   sudo pacman -S nvidia-prime
   ```

3. **Verify NVIDIA GPU works (not active by default):**

   ```bash
   prime-run glxinfo | grep "OpenGL renderer"
   ```

   It should return something like:
   ```
   OpenGL renderer string: NVIDIA GeForce GTX 1650 Ti/PCIe/SSE2
   ```

4. **Run apps with NVIDIA GPU:**

   ```bash
   prime-run blender
   prime-run python my_model.py
   prime-run ./game.sh
   ```

5. **(Optional) Avoid conflicts:** make sure there are no custom config files in `/etc/X11/xorg.conf.d/` that force NVIDIA usage.

---

## 🌐 Conclusion
- If you're unsure whether you need NVIDIA, you probably don't.
- It's safe and efficient to stick with Intel GPU only.
- If needed, you can always re-enable NVIDIA later following Option 2.

---

⚙️ This document was created to help manage hybrid GPU laptops in Arch-based environments with i3wm.

