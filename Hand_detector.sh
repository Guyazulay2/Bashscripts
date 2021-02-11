#!/bin/bash

echo """
Menu :
  (1) Install Bazel
  (2) Install OpenCV
  (3) Download mqtt-sender dependencies
  (4) Copmile Hand-Counting App
  (5) Run Hand-Counting App // ** to change mqtt url, modify .env file
  Enter 1/2/3/4/5 >:
"""
read Choice

if [ $Choice == "1" ]; then
    if [ -d "$HOME/bazel-3.4.1" ]; then
        echo "** Bazel already installed in $HOME/bazel-3.4.1 **"
    else
        echo "** Install Bazel **"
        sudo apt update
        sudo apt-get upgrade -y
        mkdir $HOME/bazel-3.4.1
        cd $HOME/bazel-3.4.1
        wget https://github.com/bazelbuild/bazel/releases/download/3.4.1/bazel-3.4.1-dist.zip
        sudo apt-get install build-essential openjdk-8-jdk python zip unzip -y
        unzip bazel-3.4.1-dist.zip
        sudo chmod 777 compile.sh
        env EXTRA_BAZEL_ARGS="--host_javabase=@local_jdk//:jdk" bash ./compile.sh
        sudo cp output/bazel /usr/local/bin/
        sleep 2
        echo "** Bazel installed Successfully **"
    fi
    
elif [ $Choice == "2" ]; then
    echo "** Change OpenCV Libary Path **" ; sed -i "s/x86_64-linux-gnu/aarch64-linux-gnu/g" third_party/opencv_linux.BUILD
    sudo apt autoremove -y
    sudo bash ./setup_opencv.sh
    
elif [ $Choice == "3" ]; then
    echo '** Downloading mqtt-sender dependencies **'
    sudo apt-get install nodejs npm
    cd mqtt-sender && npm install
    
elif [ $Choice == "4" ]; then
    echo '** Copmile Hand-Counting App **'
    sudo bazel build -c opt --copt -DMESA_EGL_NO_X11_HEADERS --copt -DEGL_NO_X11 mediapipe/examples/desktop/hand_tracking:hand_tracking_out_gpu --verbose_failures
    
elif [ $Choice == "5" ]; then
    echo '** Run App **'
    ./run.sh
    
fi
