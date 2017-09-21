#!/bin/bash
apt-get update
apt-get install -y gcc
apt-get install -y make
apt-get install -qqy linux-headers-`uname -r`
wget -P /tools http://us.download.nvidia.com/XFree86/Linux-x86_64/384.66/NVIDIA-Linux-x86_64-384.66.run

chmod +x /tools/NVIDIA-Linux-x86_64-384.66.run
sh /tools/NVIDIA-Linux-x86_64-384.66.run -a -s
nvidia-smi

sudo wget https://gist.githubusercontent.com/brianmingus/5497756754bfbcdaac34d39c2b0f0d71/raw/98e84806716d34bf514d73dbc957b35a709d9f73/nvidia_dev.bash -O /etc/init.d/nvidia
sudo chmod +x /etc/init.d/nvidia
sudo update-rc.d nvidia defaults
sudo service nvidia start

sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo sh -c ‘echo “deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /” > /etc/apt/sources.list.d/cuda.list’
sudo rm -rf /var/lib/dpkg/lock
sudo apt-get update && sudo apt-get install -y --no-install-recommends cuda-drivers
sudo rmmod nouveau | echo 0
