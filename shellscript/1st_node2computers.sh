num=$1
node_num=`printf "%03g" $num`
master=$(hostname -I)
#
#
#
#
#
#
touch ~/Documents/settings.txt
echo $(hostname -I) >> ~/Documents/settings.txt
echo master >> ~/Documents/settings.txt

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

export ROS_HOSTNAME=$(hostname -I | sed "s/\s//g")
uri=http://$master:11311
export ROS_MASTER_URI=$(echo $uri | sed "s/\s//g")

sleep 3s

gnome-terminal -- sh -c "roscore ; bash"

sleep 5s

echo MM_START: >> ~/Documents/settings.txt
echo $(date "+s") >> ~/Documents/settings.txt
############ MASTER TO MASTER ############
mode=MM
roscd ros1_test/shellscript/tools
. launch_flex_generator.sh $num Ni
echo launch file auto-generated
roscd ros1_test/launch
sleep 1s
timeout -s SIGINT 100s roslaunch auto_generated_Ni.launch
sleep 15s
cd ~/Documents
mv test_node_num_999.txt delay_${node_num}_MM.txt && :
mv cpu_used.txt cpu_used_${node_num}_MM.txt && :
mv mem_used.txt mem_used_${node_num}_MM.txt && :
mv net_count.txt net_count_${node_num}_MM.txt && :

echo MS_START: >> ~/Documents/settings.txt
echo $(date "+s") >> ~/Documents/settings.txt
########### MASTER TO SECONDARY ##########
# mode=MS
roscd ros1_test/shellscript/tools
. launch_flex_generator.sh $num Np
echo launch file auto-generated
roscd ros1_test/launch
sleep 1s
# buffer=5s
timeout -s SIGINT 125s roslaunch auto_generated_Np.launch
sleep 15s # buffer=5s
cd ~/Documents
#
mv cpu_used.txt cpu_used_${node_num}_MS.txt && :
mv mem_used.txt mem_used_${node_num}_MS.txt && :
mv net_count.txt net_count_${node_num}_MS.txt && :

echo SM_START: >> ~/Documents/settings.txt
echo $(date "+s") >> ~/Documents/settings.txt
########### SECONDARY TO MASTER ##########
mode=SM
roscd ros1_test/shellscript/tools
. launch_flex_generator.sh $num Ns
echo launch file auto-generated
roscd ros1_test/launch
sleep 1s
sleep 20s
timeout -s SIGINT 100s roslaunch auto_generated_Ns.launch
sleep 35s
cd ~/Documents
mv test_node_num_999.txt delay_${node_num}_SM.txt && :
mv cpu_used.txt cpu_used_${node_num}_SM.txt && :
mv mem_used.txt mem_used_${node_num}_SM.txt && :
mv net_count.txt net_count_${node_num}_SM.txt && :

echo SS_START: >> ~/Documents/settings.txt
echo $(date "+s") >> ~/Documents/settings.txt
######### SECONDARY TO SECONDARY #########
# mode=SS
roscd ros1_test/shellscript/tools
. launch_flex_generator.sh $num Ni
echo launch file auto-generated
sleep 1s
sleep 100s
sleep 15s
#
#
#
#
#

# clean
cd ~/Documents
dirname=result_$(date "+%Y%m%d_%H%M%S")_1st
mkdir -p $dirname/data
mv delay_* ./$dirname/data/
mv cpu_used_* ./$dirname/data
mv mem_used_* ./$dirname/data
mv net_count_* ./$dirname/data
mv ~/Documents/settings.txt ~/Documents/$dirname/

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

pid=$(lsof | grep roscore | sed "s/.*roscore//" | sed "2,\$d" | sed "s/$USERNAME.*//")
kill -SIGINT $pid
