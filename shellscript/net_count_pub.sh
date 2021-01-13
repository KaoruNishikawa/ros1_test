#!/bin/sh

# specify which file to launch #
launch_pub=net_count_pub.launch
################################
######## configuration #########
################################
export ROS_IP=$(hostname -I | cut -d' ' -f1)
export ROS_MASTER_URI=http://192.168.101.17:11311
################################


# launch
sleep 1s

for sub_num in 1 2 3 4 5 10 30 50 100
do
    cd ~/ros2/src/ros2_test/shellscript/tools
    . launch_generator_net_pub.sh $sub_num
    sleep 1s
    timeout -s SIGINT 101s roslaunch $launch_pub
    sleep 30s
done

# clean
cd ~/Documents
dirname=result_$(date "+%Y%m%d_%H%M%S")
mkdir -p $dirname/data
mv cpu_used_* ./$dirname/data/
mv cpu_temp_* ./$dirname/data/
mv mem_used_* ./$dirname/data/
mv net_count_* ./$dirname/data/
mv delay_* ./$dirname/data/

# record settings
mkdir -p $dirname/config
roscd ros1_test
cp -r * ./$dirname/config/
echo $(hostname -I) >> ./$dirname/ros1_configuration.txt
echo $ROS_IP ./$dirname/ros1_configuration.txt
echo $ROS_MASTER_URI ./$dirname/ros1_configuration.txt

# record ntp state
mkdir -p $dirname/stats
cp -r /var/log/ntpstats/* ./$dirname/stats/

# back to where I was
cd ~/ros2/src/ros2_test/shellscript
