# if you are 192.168.101.15
# export ROS_HOSTNAME=192.168.101.16
# export ROS_MASTER_URI=http://192.168.101.16:11311
# if you are 192.168.101.16
export ROS_HOSTNAME=192.168.101.15
export ROS_MASTER_URI=http://192.168.101.15:11311

sleep 5s
roscd ros1_test/launch

# PUBLISHER
# run_file=delay_pub.py
# rosrun ros1_test $run_file

# SUBSCRIBER
run_file=delay_sub.py
timeout -s SIGINT 100s rosrun ros1_test $run_file
cd ~/Documents
dirname=result_$(date "+%Y%m%d_%H%M%S")
mkdir -p $dirname/data
mv test_node_num* ./$dirname/data/
roscd ros1_test/shellscript
cp -r ./* ~/Documents/$dirname/
cp ../ros1_test/$run_file ~/Documents/$dirname/
mkdir ~/Documents/$dirname/scripts
cp ../CMakeLists.txt ~/Documents/$dirname/
cp ../package.xml ~/Documents/$dirname/
touch ~/Documents/$dirname/settings.txt

# INTRA-COMPUTER
# gnome-terminal -- sh -c "rosrun ros1_test delay_pub.py"
# run_file=delay_sub.py
# timeout -s SIGINT 100s rosrun ros1_test $run_file
# cd ~/Documents
# dirname=result_$(date "+%Y%m%d_%H%M%S")
# mkdir -p $dirname/data
# mv test_node_num* ./$dirname/data/
# roscd ros1_test/shellscript
# cp -r ./* ~/Documents/$dirname/
# cp ../ros1_test/$run_file ~/Documents/$dirname/
# mkdir ~/Documents/$dirname/scripts
# cp ../CMakeLists.txt ~/Documents/$dirname/
# cp ../package.xml ~/Documents/$dirname/
# touch ~/Documents/$dirname/settings.txt