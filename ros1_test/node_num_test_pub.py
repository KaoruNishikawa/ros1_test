#!/usr/bin/env python3

node_name = "delay_test_pub"

import rospy
import time
from std_msgs.msg import Float64

class node_num_test_pub(object):

    def __init__(self):
        self.num = str(rospy.get_param('~node_num'))
        self.my_pub = rospy.Publisher("/test/node_num_"+self.num, Float64, queue_size=1)
        self.rate = rospy.Rate(10)

    def my_publisher(self):
        while not rospy.is_shutdown():
            cur_time = time.time()
            self.my_pub.publish(cur_time)
            self.rate.sleep()


def main(args=None):
    rospy.init_node(node_name)
    pub = node_num_test_pub()
    pub.my_publisher()
    # rospy.spin()


if __name__ == "__main__":
    main()

