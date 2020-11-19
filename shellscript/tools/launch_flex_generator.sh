#!/bin/sh

node_num=$1
topic_num=$1
mode=$2

# specify which launch file to edit
roscd ros1_test/launch
launch_file=auto_generated_$mode.launch

# delete present
sed -i '/^/d' $launch_file

# generate
echo "<launch>" >> $launch_file
#
if [ $mode = 'PS' ] ; then
##################### TOPIC AND NODE #####################
# $i is for # of pub/sub pairs, and node name
# PUBLISHER
    for i in `seq $node_num`
    do
        echo "    <node pkg='ros1_test' name='delay_test_pub_$i' type='node_num_test_pub.py'>" >> $launch_file
        echo "        <param name='node_num' value='$i' />" >> $launch_file
        echo "    </node>" >> $launch_file
    done
    # SUBSCRIBER
    for i in `seq $node_num`
    do
        echo "    <node pkg='ros1_test' name='dummy_sub_$i' type='dummy_sub.py'>" >> $launch_file
        echo "        <param name='node_num' value='$i' />" >> $launch_file
        echo "    </node>" >> $launch_file
    done
#
elif [ $mode = 'P' ] ; then
########################## TOPIC #########################
# $topicnum is # of publishers/subscriptions a node create
    # PUBLISHER
    echo "    <node pkg='ros1_test' name='topic_num_test_pub' type='topic_num_test_pub.py'>" >> $launch_file
    echo "        <param name='topic_num' value='$topic_num' />" >> $launch_file
    echo "    </node>" >> $launch_file
#
elif [ $mode = 'S' ] ; then
########################## TOPIC #########################
# $topicnum is # of publishers/subscriptions a node create
    # SUBSCRIBER
    echo "    <node pkg='ros1_test' name='topic_num_test_sub' type='topic_num_test_sub.py'>" >> $launch_file
    echo "        <param name='topic_num' value='$topic_num' />" >> $launch_file
    echo "    </node>" >> $launch_file
#
elif [ $mode = 'N' ] ; then
########################## NODE ##########################
# $i is for # of nodes, and node name
# DUMMY NODE
    for i in `seq $node_num`
    do
        echo "    <node pkg='ros1_test' name='dummy_node_$i' type='dummy_node.py'>" >> $launch_file
        echo "        <param name='node_num' value='$i' />" >> $launch_file
        echo "    </node>" >> $launch_file
    done
#
fi
##########################################################
# RECORDER
echo "    <node pkg='ros1_test' name='cpu_checker' type='node_num_test_cpu.py' />" >> $launch_file
echo "    <node pkg='ros1_test' name='mem_checker' type='node_num_test_mem.py' />" >> $launch_file
echo "    <node pkg='ros1_test' name='net_checker' type='node_num_test_net.py' />" >> $launch_file
echo "    <node pkg='ros1_test' name='delay_test_pub' type='node_num_test_pub.py'>" >> $launch_file
echo "        <param name='node_num' value='999' />" >> $launch_file
echo "    </node>" >> $launch_file
echo "    <node pkg='ros1_test' name='delay_test_sub' type='node_num_test_sub.py'>" >> $launch_file
echo "        <param name='node_num' value='999' />" >> $launch_file
echo "    </node>" >> $launch_file
# end generate 
echo "</launch>" >> $launch_file
