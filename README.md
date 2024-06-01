# NixOS Passthrough
Single user NixOS config + Go application I created to streamline a lightweight QEMU based GPU passthrough sysytem.

## Features
- Optionally uses a patched version of QEMU to help hide VM status from guest

## Configurations
I only had these system configurations in mind:
- One GPU, host access via SSH or serial port
- One GPU, host starts with the GPU (unbound after shutdown of VM)
- One primary GPU, and a secondary GPU for the host

## Setup guide

#### Step 1: install NixOS
Download and install https://nixos.org/

#### Step 2: reboot, clone repo, run build
After finishing the install, start the system and in the root directory run:
```
bash ./scripts/build-after-first-install.sh
reboot
```

After finishing this guide you'll be able to rebuild the host simply by running
```
bash ./scripts/build.bash
reboot
```

#### Step 3: running post-setup script
