# esp32Qemu
#Project to emulate an esp32 firmware in QEMU and run fuzzing software on the emulated device. 

#First Step is to download and install ubuntu 24.04 using a virtualmachine platform or something similar

#After install ubuntu run update and upgrade
sudo apt update 
sudo apt upgrade -y 

#install git onto the ubuntu machine 
sudo apt install -y git 

#clone this project into the home foolder
cd ~
git clone https://github.com/CSharpMaj7/esp32Qemu.git

#cd into the project 
cd esp32Qemu

# run the installDependencies.sh script
sudo ./installDependencies.sh 

# cd back out into the home folder 
cd ~ 
#Clone the espressif fork of qemu
git clone https://github.com/espressif/qemu.git

#enter into the qemu directory
cd qemu

# update the sub modules. This part may take a while
git submodule update --init --recursive
