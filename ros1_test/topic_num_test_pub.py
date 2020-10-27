#!/usr/bin/env python3

node_name = "topic_num_test_pub"

import rospy
import time
from std_msgs.msg import Float64

class topic_num_test_pub(object):

    def __init__(self):
        self.num = int(rospy.get_param('~node_num'))
        self.num_list = [str(num) for num in range(self.num)]
        self.pub = {}
        for number in self.num_list:
            self.pub[number] = rospy.Publisher("/test/topic_num_"+number, Float64, queue_size=1)
        self.rate = rospy.Rate(10)

    def pub_data(self):
        while not rospy.is_shutdown():
            cur_time = time.time()
            for number in self.num_list:
                self.pub[number].publish(cur_time)
            self.rate.sleep()


def main(args=None):
    rospy.init_node(node_name)
    pub = topic_num_test_pub()
    pub.pub_data()


if __name__ == "__main__":
    main()

