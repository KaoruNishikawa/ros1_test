#!/usr/bin/env python3

import os
import re

import psutil
import rospy
from std_msgs.msg import Float64

node_name = "temp_checker"


class temp_checker(object):

    def __init__(self):
        self.num = int(rospy.get_param('~node_num'))
        self.f_temp = open(f"{os.environ['HOME']}/Documents/cpu_temp_{self.num:03g}.txt", "w")
        self.rate = rospy.Rate(0.5)

    def checker(self):
        while not rospy.is_shutdown():
            try:
                res_temp = psutil.sensors_temperatures()
                res_temp = str(res_temp["coretemp"])
                res_temp = re.sub(r'[\(\)\[ \]]', '', res_temp)
                res_temp = re.sub(r'shwtemp', '\n', res_temp).split('\n')[1:]  # first elem is empty
            except:
                res_temp = []
            for temp in res_temp:
                self.f_temp.write(str(temp)+'\n')
            self.rate.sleep()


def main(args=None):
    rospy.init_node(node_name)
    checker = temp_checker()
    checker.checker()


if __name__ == "__main__":
    main()
