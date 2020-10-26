#!/bin/sh

# specify which file to launch
launch_file=auto_generated.launch
node_num=5

# build
roscd ; cd ..
# catkin build
# . ./devel/setup.bash
# sleep 5s

# roscore
gnome-terminal -- sh -c "roscore; bash"
sleep 5s

# launch
for node_num in 1 20 40 60 80 100 120 140 160 180 200 220 240 260 280 300 320 340 360 380 400
do
    # generate launch file
    if [ 'auto_generated.launch' = ${launch_file} ] ; then
        echo launch file auto-generated
        roscd ros1_test/shellscript/tools
        . launch_generator.sh $node_num
    fi
    roscd ros1_test/launch
    sleep 1s
    # 
    timeout -s SIGINT 100s roslaunch $launch_file
    sleep 30s
    cd ~/Document
    node_num=`printf "%03g" $node_num`
    mv -i cpu_used.txt cpu_used_$node_num.txt && :
    mv -i mem_used.txt mem_used_$node_num.txt && :
    mv -i test_node_num_0.txt delay_${node_num}_node.txt && :
    roscd ros1_test/launch
    sleep 5s
done

# clean
cd ~/Documents
dirname=result_$(date "+%Y%m%d_%H%M%S")
mkdir -p $dirname/data
mv cpu_used_* ./$dirname/data
mv mem_used_* ./$dirname/data
mv delay_* ./$dirname/data

# record settings
cd roscd ros1_test/shellscript
cp ./* ~/Documents/$dirname/
cp ../launch/$launch_file ~/Documents/$dirname/

# back to initial directory
cd ../shellscript

