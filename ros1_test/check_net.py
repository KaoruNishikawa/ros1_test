#!/usr/bin/env python3

import os
import re

import psutil
import rospy
from std_msgs.msg import Float64

node_name = "net_checker"


class net_checker(object):

    def __init__(self):
        self.num = int(rospy.get_param('~node_num'))
        self.f_net = open(f"{os.environ['HOME']}/Documents/net_count_{self.num:03g}.txt", "w")
        self.rate = rospy.Rate(0.5)

    def checker(self):
        while not rospy.is_shutdown():
            try:
                res_net = psutil.net_io_counters()
                res_net = re.sub(r'.*?\(', '', str(res_net))
                res_net = re.sub(r'[ \)]', '', res_net)
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
