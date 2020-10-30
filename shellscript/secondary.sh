# if you are 192.168.101.15
export ROS_MASTER_URI=http://192.168.101.16:11311
# if you are 192.168.101.16
# export ROS_MASTER_URI=http://192.168.101.15:11311


roscd ros1_test/launch

#PUBLISHER
timeout -s SIGINT 100s roslaunch launch_delay_pub.launch

# SUBSCRIBER
# roslaunch launch_delay_sub.launch
# cd ~/Documents
# dirname=result_$(date "+%Y%m%d_%H%M%S")
# mkdir -p $dirname/data
# mv test_node_num* ./$dirname/data/

# INTRA-COMPUTER
# roslaunch launch_delay_pubsub.launch
# cd ~/Documents
# dirname=result_$(date "+%Y%m%d_%H%M%S")
# mkdir -p $dirname/data
# mv test_node_num* ./$dirname/data/