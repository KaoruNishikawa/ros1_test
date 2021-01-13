#!/usr/bin/env python3

import os
import re

import psutil
import rospy
from std_msgs.msg import Float64

node_name = "mem_checker"


class mem_checker(object):

    def __init__(self):
        self.num = str(rospy.get_param('~node_num'))
        self.f_mem = open(f"{os.environ['HOME']}/Documents/mem_used_{self.num}.txt", "w")
        self.rate = rospy.Rate(0.5)

    def checker(self):
        while not rospy.is_shutdown():
            try:
                res_mem = str(psutil.virtual_memory())
                res_mem = re.sub(r'.*\(', '', res_mem)
                res_mem = re.sub(r'[ \)$]', '', res_mem)
            except:
                res_mem = ""
            self.f_mem.write(res_mem+'\n')
            self.rate.sleep()


def main(args=None):
    rospy.init_node(node_name)
    checker = mem_checker()
    checker.checker()


if __name__ == "__main__":
    main()
