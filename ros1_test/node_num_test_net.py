#!/usr/bin/env python3

node_name = "net_checker"

import rospy
import os
import psutil
import subprocess
from std_msgs.msg import Float64

class net_checker(object):

    def __init__(self):
        self.f_net = open(f"{os.environ['HOME']}/Documents/net_count.txt", "w")
        self.rate = rospy.Rate(0.5)

    def checker(self):
        while not rospy.is_shutdown():
            try:
                res_net = psutil.net_io_counters()
            except:
                res_net = ""
            self.f_net.write(str(res_net)+'\n')
            self.rate.sleep()


def main(args=None):
    rospy.init_node(node_name)
    checker = net_checker()
    checker.checker()


if __name__ == "__main__":
    main()