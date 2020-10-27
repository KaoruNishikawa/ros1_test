#!/usr/bin/env python3

node_name = "dummy_node"

import rospy
import time
from std_msgs.msg import Float64

class dummy_node(object):

    def __init__(self):
        self.num = str(rospy.get_param('~node_num'))
        rospy.spin()


def main(args=None):
    rospy.init_node(node_name)
    dummy = dummy_node()


if __name__ == "__main__":
    main()

