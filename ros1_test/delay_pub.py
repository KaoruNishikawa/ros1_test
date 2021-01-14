#!/usr/bin/env python3

node_name = "delay_test_pub"

import rospy
import time
from std_msgs.msg import Float64, String

class node_num_test_pub(object):

    def __init__(self):
        self.num = int(rospy.get_param('~node_num'))
        self.topic_num = str(rospy.get_param('~topic_num'))
        self.my_pub = rospy.Publisher(f"/test/node_num_{self.topic_num}", Float64, queue_size=1)
        if int(self.topic_num) < 900:
            self.data_pub = rospy.Publisher(f"/test/data_{self.num}", String, queue_size=1)
        self.rate = rospy.Rate(10)

    def my_publisher(self):
        while not rospy.is_shutdown():
            cur_time = time.time()
            self.my_pub.publish(cur_time)
            if self.num < 900:
                data = "a" * 1000
                self.data_pub.publish(data)
            self.rate.sleep()


def main(args=None):
    rospy.init_node(node_name)
    pub = node_num_test_pub()
    pub.my_publisher()


if __name__ == "__main__":
    main()

