FROM ros:melodic-ros-base
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y \
    openssl \
    sudo \
    nano && \
    apt clean
RUN groupadd -g 1000 rr && \
    useradd -u 1000 -g 1000 -mrs /bin/bash -b /home -p $(openssl passwd -1 rr) rr 
RUN echo \
    "export ROS_MASTER_URI=http://rosmaster:11311/\n" >> ~/.bashrc \
    "export ROS_IP=\$(ifconfig eth0 | grep \"inet \" | awk -F' ' '{ print \$2 }')\n" >> ~/.bashrc
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
USER rr
