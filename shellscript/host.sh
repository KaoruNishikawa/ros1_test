export ROS_MASTER_URI=http://localhost:11311
gnome-terminal -- sh -c "roscore; bash"

sleep 15s

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