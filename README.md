# esp32Qemu
#Project to emulate an esp32 firmware in QEMU and run fuzzing software on the emulated device. 

#First Step is to download and install ubuntu 24.04 using a virtualmachine platform or something similar

#After install ubuntu run update and upgrade
sudo apt update 
sudo apt upgrade -y 

#Then install the dependecies needed to install qemu from source 
# Install required libraries and development packages => libgcrypt20 libglib2.0-0 libpixman-1-0 libsdl2-2.0-0 libslirp0 libgcrypt20-dev libslirp-dev
# Install required libraries and development packages => libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev 
# Install for max QEMU code coverage => git-email libaio-dev libbluetooth-dev libcapstone-dev libbrlapi-dev libbz2-dev libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev
# Install for max QEMU code coverage => libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev librbd-dev librdmacm-dev
# Install for max QEMU code coverage => libsasl2-dev libsdl2-dev libseccomp-dev libsnappy-dev libssh-dev libvde-dev libvdeplug-dev libvte-2.91-dev libxen-dev liblzo2-dev
# Install for max QEMU code coverage => valgrind xfslibs-dev libnfs-dev libiscsi-dev
# Install build-essential tools => build-essential git meson ninja-build
# Other tools that may be useful => binwalk 
sudo apt install -y libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev ninja-build libgcrypt20 libglib2.0-0 \
                    libpixman-1-0 libsdl2-2.0-0 libslirp0 libgcrypt20-dev libslirp-dev build-essential \
                    git-email libaio-dev libbluetooth-dev libcapstone-dev libbrlapi-dev libbz2-dev libcap-ng-dev libcurl4-gnutls-dev libgtk-3-dev \
                    libibverbs-dev libjpeg8-dev libncurses5-dev libnuma-dev librbd-dev librdmacm-dev \
                    libsasl2-dev libsdl2-dev libseccomp-dev libsnappy-dev libssh-dev libvde-dev libvdeplug-dev libvte-2.91-dev libxen-dev liblzo2-dev \ 
                    valgrind xfslibs-dev libnfs-dev libiscsi-dev \ 
                    ccache libffi-dev libssl-dev dfu-util libusb-1.0-0 \ 
                    cgcc iasl iasl-devl sphinx cil libnettle7 libnettle-dev \ 
                    libcacard-dev libu2f-emu-dev canokey-qemu-dev libusbredirparser-dev libusb-1.0-0-dev libpmem-dev libdaxctl-dev libkeyutils-dev \ 
                    libpam0g-dev libcbor-dev libpam0g-dev linux-libc-dev   libkcov-dev libgvnc-1.0-dev \ 
                    git meson ninja-build binwalk
                    
#Also install wireshark that may be useful
export DEBIAN_FRONTEND=noninteractive
echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
sudo apt-get install -y wireshark
sudo usermod -aG wireshark "$USER"

#install python and additional paython packages
sudo apt install -y python3 python python-is-python3 python3-pip python3-venv python3-sphinx-rtd-theme 


#installations of code will be done in the home directory. First install the espressif fork of qemu
git clone https://github.com/espressif/qemu.git

#enter into the qemu directory
cd qemu

# update the sub modules. This part may take a while
git submodule update --init --recursive
