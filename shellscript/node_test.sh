#!/bin/sh

# specify which file to launch
launch_file=auto_generated.launch
node_num=5

# build
roscd ; cd ..
# catkin build
# . ./devel/setup.bash
# sleep 5s

# roscore
gnome-terminal -- sh -c "roscore; bash"
sleep 5s

# for node_num in 1 20 40 60 80 100 120 140 160 180 200 220 240 260 280 300 320 340 360 380 400
# do
# 
# generate launch file
if [ 'auto_generated.launch' = ${launch_file} ] ; then
    echo launch file auto-generated
    roscd ; cd ../src/ros1_test/shellscript/tools
    . launch_generator.sh $node_num
fi
# 
# launch
roscd ; cd ../src/ros1_test/launch
sleep 1s
#
timeout -s SIGINT 100s roslaunch $launch_file
#     sleep 30s
#     cd ~/Document
#     mv
#     mv
#     mv
#     cd ~/ros1/src/ros1_test/launch
#     sleep 5s
# done

# clean

# record settings

# back to initial directory
cd ../shellscript
