#!/bin/sh

node_num=$1

# specify which launch file to edit
roscd ros1_test/launch
launch_file=auto_generated.launch

# delete present
sed -i '/^/d' $launch_file

# generate
echo "<launch>" >> $launch_file
# publisher
for i in `seq $node_num`
do
    echo "    <node pkg='ros1_test' name='delay_test_pub_$i' type='node_num_test_pub.py'>" >> $launch_file
    echo "        <param name='node_num' value='$i' />" >> $launch_file
    echo "    </node>" >> $launch_file
done
# subscriber
for i in `seq $node_num`
do
    echo "    <node pkg='ros1_test' name='delay_test_sub_$i' type='node_num_test_sub.py'>" >> $launch_file
    echo "        <param name='node_num' value='$i' />" >> $launch_file
    echo "    </node>" >> $launch_file
done
# recorder
echo "    <node pkg='ros1_test' name='cpu_checker' type='node_num_test_cpu.py' />" >> $launch_file
echo "    <node pkg='ros1_test' name='mem_checker' type='node_num_test_mem.py' />" >> $launch_file
# 
echo "</launch>" >> $launch_file
