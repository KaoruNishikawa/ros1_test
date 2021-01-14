#!/usr/bin/env python3

node_name = "dummy_sub"

import rospy
import time
import os
from std_msgs.msg import String

class dummy_sub(object):

    def __init__(self):
        self.num = str(rospy.get_param('~node_num'))
        my_sub = rospy.Subscriber("/test/data_"+self.num, String, self.sub_callback, queue_size=1)
        rospy.spin()

    def sub_callback(self, data):
        length = len(str(data))
        # cur_time = time.time()
        # send_time = timer.data
        # delta = cur_time - send_time


def main(args=None):
    rospy.init_node(node_name)
    sub = dummy_sub()


if __name__ == "__main__":
    main()

