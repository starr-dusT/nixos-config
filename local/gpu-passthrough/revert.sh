#!/run/current-system/sw/bin/bash

set -x

# Unload VFIO-PCI Kernel Driver
modprobe -r vfio_pci
modprobe -r vfio_iommu_type1
modprobe -r vfio

# Rebind VT consoles
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind

# Read our nvidia configuration when before starting our graphics
nvidia-xconfig --query-gpu-info > /dev/null 2>&1

# Re-Bind EFI-Framebuffer
echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind 
echo "simple-framebuffer.0" > /sys/bus/platform/drivers/simple-framebuffer/bind 
echo "vesa-framebuffer.0" > /sys/bus/platform/drivers/vesa-framebuffer/bind 

# ZzzzzzZzz
sleep 1

# Load nvidia drivers
modprobe nvidia_drm
modprobe nvidia_modeset
modprobe drm_kms_helper
modprobe nvidia
modprobe i2c_nvidia_gpu
modprobe drm
modprobe snd_hda_intel

# Restart Display Manager
systemctl start display-manager.service
