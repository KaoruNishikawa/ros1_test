#!/bin/sh

# specify which file to launch
launch_file=launch_node_num_test.launch

# build
cd ~/ros1
# catkin build
# . ./devel/setup.bash
# sleep 5s

# roscore
gnome-terminal -- sh -c "roscore; bash"
sleep 5s

# launch
cd src/ros1_test/launch
sleep 1s
#
# for node_num in 1 20 40 60 80 100 120 140 160 180 200 220 240 260 280 300 320 340 360 380 400
# do
#     sed
#     sleep 1s
roslaunch $launch_file
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
