# if you are 192.168.101.15
export ROS_MASTER_URI=http://192.168.101.16:11311
# if you are 192.168.101.16
# export ROS_MASTER_URI=http://192.168.101.15:11311

roscd ros1_test/launch

# PUBLISHER
roslaunch launch_delay_pub.launch

# SUBSCRIBER
# timeout -s SIGINT 100s roslaunch launch_delay_sub.launch
# cd ~/Documents
# dirname=result_$(date "+%Y%m%d_%H%M%S")
# mkdir -p $dirname/data
# mv test_node_num* ./$dirname/data/
# roscd ros1_test/shellscript
# cp -r ./* ~/Documents/$dirname/
# cp ../launch/$launch_file ~/Documents/$dirname/
# mkdir ~/Documents/$dirname/scripts
# cp -r ../ros1_test/* ~/Documents/$dirname/scripts/
# cp ../CMakeLists.txt ~/Documents/$dirname/
# cp ../package.xml ~/Documents/$dirname/
# touch ~/Documents/$dirname/settings.txt

# INTRA-COMPUTER
# timeout -s SIGINT 100s roslaunch launch_delay_pubsub.launch
# cd ~/Documents
# dirname=result_$(date "+%Y%m%d_%H%M%S")
# mkdir -p $dirname/data
# mv test_node_num* ./$dirname/data/
# roscd ros1_test/shellscript
# cp -r ./* ~/Documents/$dirname/
# cp ../launch/$launch_file ~/Documents/$dirname/
# mkdir ~/Documents/$dirname/scripts
# cp -r ../ros1_test/* ~/Documents/$dirname/scripts/
# cp ../CMakeLists.txt ~/Documents/$dirname/
# cp ../package.xml ~/Documents/$dirname/
# touch ~/Documents/$dirname/settings.txt