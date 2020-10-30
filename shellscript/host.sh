export ROS_MASTER_URI=http://localhost:11311
gnome-terminal -- sh -c "roscore; bash"

sleep 15s

#PUBLISHER
timeout -s SIGINT 100s roslaunch launch_delay_pub.launch

# SUBSCRIBER
# roslaunch launch_delay_sub.launch