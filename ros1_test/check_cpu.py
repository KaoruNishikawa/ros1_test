#!/usr/bin/env python3

import os

import psutil
import rospy
from std_msgs.msg import Float64

node_name = "cpu_checker"


class cpu_checker(object):

    def __init__(self):
        self.num = int(rospy.get_param('~node_num'))
        self.f_cpu = open(f"{os.environ['HOME']}/Documents/cpu_used_{self.num:03g}.txt", "w")
        self.rate = rospy.Rate(0.5)

    def checker(self):
        while not rospy.is_shutdown():
            try:
                res_cpu = psutil.cpu_percent(interval=0.5, percpu=True)
                res_cpu = " ".join([str(res) for res in res_cpu])
            except:
                res_cpu = ""
            self.f_cpu.write(res_cpu+'\n')
            self.rate.sleep()


def main(args=None):
    rospy.init_node(node_name)
    checker = cpu_checker()
    checker.checker()


if __name__ == "__main__":
    main()
