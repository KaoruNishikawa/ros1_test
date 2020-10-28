#!/usr/bin/env python3

node_name = "mem_checker"

import rospy
import os
import psutil
import subprocess
from std_msgs.msg import Float64

class mem_checker(object):

    def __init__(self):
        self.f_mem = open(f"{os.environ['HOME']}/Documents/mem_used.txt", "w")
        self.rate = rospy.Rate(1)

    def checker(self):
        while not rospy.is_shutdown():
            try:
                # top_command = 'top -b -n1'
                # command_mem = 'grep buff/cache'
                # res_mem1 = subprocess.Popen(top_command.split(' '), stdout=subprocess.PIPE)
                # res_mem2 = subprocess.Popen(command_mem.split(' '), stdin=res_mem1.stdout, stdout=subprocess.PIPE)
                # res_mem = res_mem2.communicate()[0]
                res_mem = psutil.virtual_memory()
            except:
                res_mem = ""
            self.f_mem.write(str(res_mem)+'\n')
            self.rate.sleep()


def main(args=None):
    rospy.init_node(node_name)
    checker = mem_checker()
    checker.checker()


if __name__ == "__main__":
    main()

