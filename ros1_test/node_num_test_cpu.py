#!/usr/bin/env python3

node_name = "cpu_checker"

import rospy
import os
import psutil
import subprocess
from std_msgs.msg import Float64

class cpu_checker(object):

    def __init__(self):
        self.f_cpu = open(f"{os.environ['HOME']}/Documents/cpu_used.txt", "w")
        self.rate = rospy.Rate(0.5)

    def checker(self):
        while not rospy.is_shutdown():
            try:
                # top_command = 'top -b -n1'
                # command_cpu = 'grep Cpu'
                # res_cpu1 = subprocess.Popen(top_command.split(' '), stdout=subprocess.PIPE)
                # res_cpu2 = subprocess.Popen(command_cpu.split(' '), stdin=res_cpu1.stdout, stdout=subprocess.PIPE)
                # res_cpu = res_cpu2.communicate()[0]
                res_cpu = psutil.cpu_percent(interval=0.5)
            except:
                res_cpu = ""
            self.f_cpu.write(str(res_cpu)+'\n')
            self.rate.sleep()


def main(args=None):
    rospy.init_node(node_name)
    checker = cpu_checker()
    checker.checker()


if __name__ == "__main__":
    main()

