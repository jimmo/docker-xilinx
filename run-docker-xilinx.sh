xhost +
docker run --network host --rm -ti -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v $HOME/.Xilinx:/home/xilinx/.Xilinx -v $HOME/src:/home/xilinx/src xilinx-ise-ubuntu /home/xilinx/run-xilinx.sh
