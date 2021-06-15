#!/bin/bash


# Before you run change the config file or add some video to the demos directory 
echo '-- Pull New videos from s3 --'
sleep 1
cd /home/ubuntu/demos
aws s3 cp s3://demosvideos/upload/$1 .


# Run the app inside the docker container
echo '-- Run the docker --'
sudo docker run --gpus all -d --name mindfly --network=host --rm -v /home/ubuntu/configs/:/workspace/Mindfly/ball_person_tracking/configs -v /home/ubuntu/demos:/workspace/Mindfly/ball_person_tracking/demos -w /workspace/Mindfly/ball_person_tracking bd286eee8290 python3 -m mindfly_tracking -c "/workspace/Mindfly/ball_person_tracking/configs/$2"


# Check if the docker finished 
while [ $( sudo docker ps -a -f name=mindfly | wc -l ) -eq 2 ]
do
    sleep 5
    echo 'smart cropping is still running ...'

done

# Upload the output files to s3
echo '-- Upload the output to the s3 --'

sleep 1
cd /home/ubuntu/demos
sudo rm $1
aws s3 cp /home/ubuntu/demos s3://demosvideos/output/ --recursive
sleep 2
sudo rm *mp4
