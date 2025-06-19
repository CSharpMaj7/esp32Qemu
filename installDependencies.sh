sudo apt update 
sudo apt upgrade -y 

sudo apt install -y \
  binwalk build-essential cmake ccache dfu-util git git-email acpica-tools libaio-dev \
  libbluetooth-dev libbrlapi-dev libbz2-dev libcacard-dev libcap-ng-dev \
  libcapstone-dev libcbor-dev libcups2-dev libcurl4-gnutls-dev libdaxctl-dev \
  libffi-dev libfdt-dev libgcrypt20 libgcrypt20-dev libglib2.0-0t64 \
  libglib2.0-dev libgtk-3-dev libibverbs-dev libiscsi-dev libjpeg-dev \
  libkeyutils-dev liblzo2-dev libnettle8t64 \
  libncurses-dev libnfs-dev libnuma-dev libpam0g-dev libpixman-1-0 \
  libpixman-1-dev libpmem-dev librbd-dev librdmacm-dev libsasl2-dev \
  libsdl2-2.0-0 libsdl2-dev libseccomp-dev libslirp-dev libslirp0 \
  libsnappy-dev libssh-dev libssl-dev libusb-1.0-0 libusb-1.0-0-dev \
  libusbredirparser-dev libvde-dev libvdeplug-dev \
  libvte-2.91-dev libxen-dev libzstd-dev linux-libc-dev meson ninja-build \
  platformio sphinx-doc valgrind xfslibs-dev
  
sudo apt install -y \
  clang python3 python3-pip python3-sphinx python3-setuptools \
  python-is-python3 python3-venv python3-sphinx-rtd-theme \
  libspice-server-dev libpulse-dev libvncserver-dev libxrandr-dev \
  libxfixes-dev libxinerama-dev libxext-dev libx11-dev libxcb1-dev \
  libxkbcommon-dev libdrm-dev libsdl2-image-dev libgtk-4-dev \
  libopus-dev libzstd-dev lzop
  
  export DEBIAN_FRONTEND=noninteractive
  echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
  sudo apt-get install -y wireshark 
