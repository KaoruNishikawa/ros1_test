num=$1
if [ $(hostname -I) = '192.168.101.15' ] ; then
    master=192.168.101.16
elif [ $(hostname -I) = '192.168.101.16' ] ; then
    master=192.168.101.15
else
    exit 1
fi

#
#
#
#
#
#
#
#
#
#
# echo START

export ROS_HOSTNAME=$(hostname -I | sed "s/\s//g")
uri=http://$master:11311
export ROS_MASTER_URI=$(echo $uri | sed "s/\s//g")

sleep 3s

# gnome-terminal -- sh -c "roscore ; bash"

sleep 5s

############ MASTER TO MASTER ############
# mode=MM
roscd ros1_test/shellscript/tools
. launch_flex_generator.sh $num N
echo launch file auto-generated
roscd ros1_test/launch
sleep 1s
sleep 100s
sleep 15s
#
#

########### MASTER TO SECONDARY ##########
mode=MS
roscd ros1_test/shellscript/tools
. launch_flex_generator.sh $num N
echo launch file auto-generated
roscd ros1_test/launch
sleep 1s
sleep 5s
timeout -s SIGINT 100s roslaunch auto_generated_N.launch
sleep 20s
cd ~/Documents
mv -i test_node_num_1.txt delay_$mode.txt && :

########### SECONDARY TO MASTER ##########
# mode=SM
roscd ros1_test/shellscript/tools
. launch_flex_generator.sh $num N
echo launch file auto-generated
roscd ros1_test/launch
sleep 1s
# buffer=10s
timeout -s SIGINT 120s roslaunch auto_generated_N.launch
sleep 15s # buffer=10s
#
#

######### SECONDARY TO SECONDARY #########
mode=SS
roscd ros1_test/shellscript/tools
. launch_flex_generator.sh $num N
echo launch file auto-generated
sleep 1s
timeout -s SIGINT 100s roslaunch auto_generated_N.launch
sleep 15s
cd ~/Documents
mv -i test_node_num_1.txt delay_$mode.txt && :

# clean
cd ~/Documents
dirname=result_$(date "+%Y%m%d_%H%M%S")_2nd
mkdir -p $dirname/data
mv delay_* ./$dirname/data

# record settings
roscd ros1_test/shellscript
cp -r ./* ~/Documents/$dirname/
cp -r ../launch/auto_generated* ~/Documents/$dirname/
mkdir ~/Documents/$dirname/scripts
cp -r ../ros1_test/* ~/Documents/$dirname/scripts/
cp ../CMakeLists.txt ~/Documents/$dirname/
cp ../package.xml ~/Documents/$dirname/
touch ~/Documents/$dirname/settings.txt
echo "$(hostname -I) secondary" >> ~/Documents/$dirname/settings.txt

# try : kill
# roscore
