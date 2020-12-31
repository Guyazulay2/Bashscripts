#!/bin/bash

echo """
Menu :
  (1) Install Bazel & Install OpenCV  & Copmile Hand-Counting App
  (2) Run Hand-Counting App
  Enter 1 or 2 >:
"""
read Choice

if [ $Choice == "1" ]; then
    if [ "$(dpkg -l | awk '/bazel/ {print }'|wc -l)" -ge 1 ]; then

        echo "** Bazel exists **"
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
    
    echo "** Change Libary Path **" ; sed -i "s/x86_64-linux-gnu/aarch64-linux-gnu/g" third_party/opencv_linux.BUILD

    echo "** Cloning Hand_detector Repo **" ; cd $HOME && sudo git clone https://github.com/dspip/Hand_detector.git
    sudo apt autoremove -y
    cd $HOME/Hand_detector ; sudo bash ./setup_opencv.sh


    echo '** Copmile Hand-Counting App **'
    cd $HOME/Hand_detector ; bazel build -c opt --copt -DMESA_EGL_NO_X11_HEADERS --copt -DEGL_NO_X11 mediapipe/examples/desktop/hand_tracking:hand_tracking_out_gpu --verbose_failures


elif [ $Choice == "2" ]; then

    echo '** Hand-Counting App **'
    cd $HOME/Hand_detector ; GLOG_logtostderr=1 bazel-bin/mediapipe/examples/desktop/hand_tracking/hand_tracking_out_gpu --calculator_graph_config_file=mediapipe/graphs/hand_tracking/hand_tracking_desktop_live_gpu.pbtxt

fi
