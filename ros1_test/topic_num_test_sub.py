#!/usr/bin/env python3

node_num = "topic_num_test_sub"

import rospy
import time
import os
from std_msgs.msg import Float64

class topic_num_test_sub(object):

    def __init__(self):
        self.num = int(rospy.get_param('~topic_num'))
        self.num_list = [str(num) for num in range(self.num)]
        sub = {}
        for number in self.num_list:
            sub[number] = rospy.Subscriber("/test/topic_num_"+number, Float64, self.sub_callback, queue_size=1)
        rospy.spin()

    def sub_callback(self, timer):
        cur_time = time.time()
        send_time = timer.data
        delta = cur_time - send_time


def main(args=None):
    rospy.init_node(node_name)
    sub = topic_num_test_sub()


if __name__ == "__main__":
    main()

