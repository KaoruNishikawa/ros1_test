#!/usr/bin/env python3

node_name = "delay_test_sub"

import rospy
import time
import os
from std_msgs.msg import Float64

class node_num_test_sub(object):

    def __init__(self):
        self.num = str(rospy.get_param('~node_num'))
        self.topic_num = str(rospy.get_param('~topic_num'))
        self.f = open(f"{os.environ['HOME']}/Documents/test_node_num_{self.node_num}.txt", "w")
        my_sub = rospy.Subscriber(f"/test/node_num_{self.topic_num}", Float64, self.sub_callback, queue_size=1)
        rospy.spin()

    def sub_callback(self, timer):
        cur_time = time.time()
        send_time = timer.data
        delta = cur_time - send_time
        self.f.write(str(delta)+'\n')


def main(args=None):
    rospy.init_node(node_name)
    sub = node_num_test_sub()


if __name__ == "__main__":
    main()

