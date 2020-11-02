master=$(hostname -I)
#
#
#
#
#
#

echo "start 2nd_2computers in 5 sec."
sleep 1s
echo "4"
sleep 1s
echo "3"
sleep 1s
echo "2"
sleep 1s
echo "1"
sleep 1s
echo START

export ROS_HOSTNAME=$(hostname -I)
uri=http://$master:11311
export ROS_MASTER_URI=$(echo $uri | sed "s/\s//g")

sleep 3s

gnome-terminal -- sh -c "roscore ; bash"

sleep 5s

############ MASTER TO MASTER ############
mode=MM
roscd ros1_test/launch
sleep 1s
timeout -s SIGINT 100s roslaunch launch_delay_pubsub.launch
sleep 15s
cd ~/Documents
mv -i test_node_num_1.txt delay_$mode.txt && :

########### MASTER TO SECONDARY ##########
# mode=MS
roscd ros1_test/launch
sleep 1s
# buffer=5s
timeout -s SIGINT 110s roslaunch launch_delay_pub.launch
sleep 15s # buffer=5s
#
#

########### SECONDARY TO MASTER ##########
mode=SM
#
sleep 1s
sleep 10s
timeout -s SIGINT 100s roslaunch launch_delay_sub.launch
sleep 25s
cd ~/Documents
mv -i test_node_num_1.txt delay_$mode.txt && :

######### SECONDARY TO SECONDARY #########
# mode=SS
sleep 1s
sleep 100s
sleep 15s
#
#

# clean
cd ~/Documents
dirname=result_$(date "+%Y%m%d_%H%M%S")
mkdir -p $dirname/data
mv delay_* ./$dirname/data

# record settings
roscd ros1_test/shellscript
cp -r ./* ~/Documents/$dirname/
cp -r ../launch/launch_delay* ~/Documents/$dirname/
mkdir ~/Documents/$dirname/scripts
cp -r ../ros1_test/* ~/Documents/$dirname/scripts/
cp ../CMakeLists.txt ~/Documents/$dirname/
cp ../package.xml ~/Documents/$dirname/
touch ~/Documents/$dirname/settings.txt
echo "$(hostname -I) master" >> ~/Documents/$dirname/settings.txt

pid=$(lsof | grep roscore | sed "s/.*roscore//" | sed "2,\$d" | sed "s/$USERNAME.*//")
kill -SIGINT $pid
