This project aims to emulate the Tasmota ESP32 firmware using the ESP32-capable fork of QEMU provided by Espressif. The goal is to create a reproducible environment to run and test Tasmota firmware in a virtualized setup without real hardware.

---

## Project Overview

1. Install Ubuntu 24.04 on a virtual machine or other environment
2. Install required build dependencies
3. Download and install the Espressif ESP-IDF (`idf.py`)
4. Clone and compile the Espressif fork of QEMU
5. Download and build Tasmota firmware for ESP32
6. Emulate the firmware using QEMU

---

## Prerequisites

- A system running **Ubuntu 24.04** (VM, WSL2, bare metal, etc.)
- Internet access

---

## Step 1: Install Ubuntu 24.04

Use any virtualization platform (VirtualBox, VMware, KVM, WSL2, etc.) to install a clean copy of **Ubuntu 24.04**. A minimum of 4GB RAM and 2 CPUs is recommended.

###After install ubuntu run update and upgrade
<pre> ```bash
sudo apt update 
sudo apt upgrade -y 
 ``` </pre>
###install git onto the ubuntu machine 

sudo apt install -y git 

###clone this project into the home foolder
cd ~

git clone https://github.com/CSharpMaj7/esp32Qemu.git

###cd into the project 
cd esp32Qemu

## Step 2: Install Build Dependencies

All required packages for building QEMU and supporting tools are listed in the script below.

### Run the installation script

chmod +x installDependencies.sh

./installDependencies.sh

## Step 3: Install the Espressif ESP-IDF
cd ~ 

git clone --recursive https://github.com/espressif/esp-idf.git

cd esp-idf

./install.sh

#### Important command and must be run in every bash session before running the expressif tools
. export.sh


## Step 4: Clone and Build the Espressif QEMU Fork
cd ~ 

git clone https://github.com/espressif/qemu.git

cd qemu

./configure --target-list=xtensa-softmmu \
    --enable-gcrypt \
    --enable-slirp \
    --enable-debug \
    --enable-sdl \
    --disable-strip --disable-user \
    --disable-capstone --disable-vnc \
    --disable-gtk
    
ninja -C build


## Step 4.5: Setup platformio
virtualenv platformio-core

cd platformio-core

. bin/activate

pip install -U platformio

pip install --upgrade pip

 
## Step 5: Download and Build the Tasmota Project
cd ~/platformio-core

git clone https://github.com/arendst/Tasmota.git

cd Tasmota


rm -rf .pio

pio run -t clean

pio run -e tasmota32

//pio run 2>&1 | tee build.log

//platformio run -e tasmota32

deactivate

#### Ensure your ESP-IDF environment from Step 3 is active
idf.py set-target esp32
sed -i 's/^CONFIG_MBEDTLS_CERTIFICATE_BUNDLE_MAX_CERTS=.*/CONFIG_MBEDTLS_CERTIFICATE_BUNDLE_MAX_CERTS=200/' sdkconfig
idf.py menuconfig
Component config  --->
  mbedTLS  --->
    Certificate Bundle  --->
      Max number of certificates in bundle
      set value to 200
idf.py build

###  Step 7: Combine the binary files

cd ~ 

mkdir working

esptool.py --chip esp32 merge_bin \
  --fill-flash-size 4MB \
  --flash_mode dio \
  --flash_freq 40m \
  --flash_size 4MB \
  -o flash_image.bin \
  0x1000  ~/platformio-core/Tasmota/.pio/build/tasmota32/bootloader.bin \
  0x8000  ~/platformio-core/Tasmota/.pio/build/tasmota32/partitions.bin \
  0xe000  ~/.platformio/packages/framework-arduinoespressif32/tools/partitions/boot_app0.bin \
  0x10000 ~/platformio-core/Tasmota/variants/tasmota/tasmota32-safeboot.bin \
  0xe0000 ~/platformio-core/Tasmota/.pio/build/tasmota32/firmware.bin

~/qemu/build/qemu-system-xtensa \
  -nographic \
  -M esp32 \
  -m 4M \
  -drive file=flash_image.bin,format=raw,if=mtd \
  -global driver=esp32.spi_flash,property=drive,value=flash \
  -global driver=timer.esp32.timg,property=wdt_disable,value=true\
  -nic user,model=open_eth \ 
  -display sdl \
  -serial stdio

