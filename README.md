# ros1_test

ROS 1 performance tests.

## Running the Tests

1. **Communication Overhead Between 2 Computers**

    - \# of publishers = 1
    - \# of subscribers = 1
    - \# of nodes = 2
    - \# of topics = 1
    - Measured parameters = Overhead

    4 measurements involving 2 machines are done:

    - Computer1 -(msg)-> Computer1
    - Computer1 -(msg)-> Computer2
    - Computer2 -(msg)-> Computer1
    - Computer2 -(msg)-> Computer2

    While `roscore` is always running on Computer1.

    To run this test, please configure the IP addresses in `shellscript/2nd_2computers.sh`; just set the IPs of 2 computers you're using.

    1. Run the following command on Computer1.

        ```shell
        . shellscript/1st_2computers.sh
        # Automatically start roscore, then run the measurements
        ```

    2. Then countdown shows up. When it hits `0`, execute the next command on Computer2.

        ```shell
        . shellscript/2nd_2computers.sh
        ```

    The results will be saved at `~/Documents/result_YYYYMMSS_hhmmss`.

    This test doesn't take time offset per machine into account, so the overhead (typically ~1ms) can become negative values. Try changing NTP configurations, or averaging multiple tests swapping machines the `roscore` is running on.

    *`<machine>` parameter in launch files may improve the readability, but I was lazy just configuring it...*

2. **Load Tests with Different Number of Nodes**

    - \# of publishers = 1 (for delay measurement)
    - \# of subscribers = 1 (for delay measurement)
    - \# of nodes = arbitrary_num + 4
    - \# of topics = 1 (for delay measurement)
    - Measured parameters = Overhead, CPU usage \[%\], RAM usage \[%\], Network sent/recv \[bytes\]

    Basically same as 1. but increasing dummy (have no publishers nor subscribers) nodes.

    To run this test, please configure the IP addresses in `shellscript/2nd_node2computers.sh`

    1. Run the following command on Computer1, specifying \# of dummy nodes.

        ```shell
        . shellscript/1st_node2computers.sh 75
        # Automatically generate launch file, start roscore, then run the measurements
        # This example starts 75 dummy nodes + 4 measurement nodes
        ```

    2. When countdown hits `0`, execute the next command on Computer2.

        ```shell
        . shellscript/2nd_node2computers.sh 75
        ```

3. **Load Tests with Different Number of Topics**

    - \# of publishers = arbitrary_num + 1
    - \# of subscribers = arbitrary_num + 1
    - \# of nodes = 2 + 4
    - \# of topics = arbitrary_num + 1
    - Measured parameters = Overhead, CPU usage \[%\], RAM usage \[%\], Network sent/recv \[bytes\]

    Basically same as 1. but increasing dummy (communicating float64 timestamp) topics.

    To run this test, please configure the IP addresses in `shellscript/2nd_node2computers.sh`

    1. Run the following command on Computer1, specifying \# of dummy nodes.

        ```shell
        . shellscript/1st_topic2computers.sh 75
        # Automatically generate launch file, start roscore, then run the measurements
        # This example starts 75 dummy topics + 1 topic for overhead recording
        ```

    2. When countdown hits `0`, execute the next command on Computer2.

        ```shell
        . shellscript/2nd_topic2computers.sh 75
        ```

4. **Load Tests changing Number of Nodes**

    - \# of publishers = 1
    - \# of subscribers = 1
    - \# of nodes = various + 4
    - \# of topics = 1
    - Measured parameters = Overhead, CPU usage \[%\], RAM usage \[%\], Network sent/recv \[bytes\]

    Basically same as 2., but inter-computer communications are not measured.

    1. Running the following command executes tests with \# of nodes = 1, 20, 40, ..., 400

        ```shell
        . shellscript/node_test.sh
        ```

## Visualizing the Result

I haven't prepared the visualization tool for this repo, but maybe [ros2_test/analysis](https://github.com/KaoruNishikawa/ros2_test/tree/main/analysis) can be used, with minor change.
