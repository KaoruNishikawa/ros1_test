#!/bin/sh

sub_num=$1

# specify which launch file to edit
roscd ros1_test/launch
launch_file=net_count_pub.launch

# delete present
sed -i '/^/d' $launch_file

# generate
echo "<launch>" >> $launch_file
########################## NODE ##########################
# $i is for # of nodes, and node name
# DUMMY NODE
# for i in `seq $sub_num`
# do
#     echo "    <node pkg='ros1_test' name='dummy_sub_$i' type='dummy_sub.py'>" >> $launch_file
#     echo "        <param name='node_num' value='$i' />" >> $launch_file
#     echo "    </node>" >> $launch_file
# done
echo "    <node pkg='ros1_test' name='dummy_pub_0' type='delay_pub.py'>" >> $launch_file
echo "        <param name='node_num' value='0' />" >> $launch_file
echo "        <param name='topic_num' value='0' />" >> $launch_file
echo "    </node>" >> $launch_file
##########################################################
# RECORDER
echo "    <node pkg='ros1_test' name='temp_checker' type='check_temp.py' />" >> $launch_file
echo "    <node pkg='ros1_test' name='net_checker' type='check_net.py' />" >> $launch_file
echo "    <node pkg='ros1_test' name='mem_checker' type='check_mem.py' />" >> $launch_file
echo "    <node pkg='ros1_test' name='net_checker' type='check_net.py' />" >> $launch_file
echo "    <node pkg='ros1_test' name='delay_pub' type='delay_pub.py'>" >> $launch_file
echo "        <param name='node_num' value='${sub_num}' />" >> $launch_file
echo "        <param name='topic_num' value='998' />" >> $launch_file
echo "    </node>" >> $launch_file
echo "    <node pkg='ros1_test' name='delay_sub' type='delay_sub.py'>" >> $launch_file
echo "        <param name='node_num' value='${sub_num}' />" >> $launch_file
echo "        <param name='topic_num' value='999' />" >> $launch_file
echo "    </node>" >> $launch_file
# end generate 
echo "</launch>" >> $launch_file
