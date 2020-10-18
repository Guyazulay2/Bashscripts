#!/bin/bash


DIR=/usr/local/cuda/
if [ -d "$DIR" ]; then

        echo ">> Cuda exists <<!"
        sleep 2
else

        echo "<< Install cuda 10.2 >>"
        wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin

        sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600

        wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb

        sudo dpkg -i cuda-repo-ubuntu1804-10-2-local-10.2.89-440.33.01_1.0-1_amd64.deb

        sudo apt-key add /var/cuda-repo-10-2-local-10.2.89-440.33.01/7fa2af80.pub
        sudo apt-get update
        sudo apt-get -y install cuda

        sleep 3

fi

DIR2=/etc/nvidia-container-runtime
if [ -d "$DIR" ]; then

        echo ">> Nvidia-Docker2 exists <<!"
        sleep 2
else

        echo "<< Install nvidia-docker >>"
        sleep 2
        distribution=$(. /etc/os-release;echo $ID$VERSION_ID)

        curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -

        curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list


        sudo apt-get update && sudo apt-get install -y nvidia-docker2
        sudo systemctl restart docker
        sleep 3; nvidia-smi

fi


### EOF ###
