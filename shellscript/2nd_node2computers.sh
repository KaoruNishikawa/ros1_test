num=$1
node_num=`printf "%03g" $num`
if [ $(hostname -I) = '192.168.101.15' ] ; then
    master=192.168.101.16
elif [ $(hostname -I) = '192.168.101.16' ] ; then
    master=192.168.101.15
else
    exit 1
fi
touch ~/Documents/$dirname/settings.txt
echo $(hostname -I) >> ~/Documents/$dirname/settings.txt
echo secondary >> ~/Documents/$dirname/settings.txt

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

echo MM_START: >> ~/Documents/$dirname/settings.txt
echo $(date "+s") >> ~/Documents/$dirname/settings.txt
############ MASTER TO MASTER ############
# mode=MM
roscd ros1_test/shellscript/tools
. launch_flex_generator.sh $num Ns
echo launch file auto-generated
roscd ros1_test/launch
sleep 1s
sleep 100s
sleep 15s
#
#

echo MS_START: >> ~/Documents/$dirname/settings.txt
echo $(date "+s") >> ~/Documents/$dirname/settings.txt
########### MASTER TO SECONDARY ##########
mode=MS
roscd ros1_test/shellscript/tools
. launch_flex_generator.sh $num Ns
echo launch file auto-generated
roscd ros1_test/launch
sleep 1s
sleep 5s
timeout -s SIGINT 100s roslaunch auto_generated_N.launch
sleep 20s
cd ~/Documents
mv -i test_node_num_999.txt delay_$node_num.txt && :

echo SM_START: >> ~/Documents/$dirname/settings.txt
echo $(date "+s") >> ~/Documents/$dirname/settings.txt
########### SECONDARY TO MASTER ##########
# mode=SM
roscd ros1_test/shellscript/tools
. launch_flex_generator.sh $num Ns
echo launch file auto-generated
roscd ros1_test/launch
sleep 1s
# buffer=10s
timeout -s SIGINT 120s roslaunch auto_generated_N.launch
sleep 15s # buffer=10s
#
#

echo SS_START: >> ~/Documents/$dirname/settings.txt
echo $(date "+s") >> ~/Documents/$dirname/settings.txt
######### SECONDARY TO SECONDARY #########
mode=SS
roscd ros1_test/shellscript/tools
. launch_flex_generator.sh $num Ns
echo launch file auto-generated
sleep 1s
timeout -s SIGINT 100s roslaunch auto_generated_N.launch
sleep 15s
cd ~/Documents
mv -i test_node_num_999.txt delay_$node_num.txt && :

# clean
cd ~/Documents
dirname=result_$(date "+%Y%m%d_%H%M%S")_2nd
mkdir -p $dirname/data
mv delay_* ./$dirname/data/

# record settings
roscd ros1_test/shellscript
cp -r ./* ~/Documents/$dirname/
cp -r ../launch/auto_generated* ~/Documents/$dirname/
mkdir ~/Documents/$dirname/scripts
cp -r ../ros1_test/* ~/Documents/$dirname/scripts/
cp ../CMakeLists.txt ~/Documents/$dirname/
cp ../package.xml ~/Documents/$dirname/
mkdir ~/Documents/$dirname/stats
cp -r /var/log/ntpstats/* ~/Documents/$dirname/stats/

# try : kill
# roscore
