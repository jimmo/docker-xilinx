# xilinx-docker

Dockerize Xilinx FPGA tools to allow running ISE on modern Linux.

# Building base image
```
docker build -t xilinx-ise-ubuntu .
```

# Installing ISE
```
xhost +
docker run -ti -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v $HOME/.Xilinx:/home/xilinx/.Xilinx -v /path/to/install/files:/media/xilinx xilinx-ise-ubuntu
/media/xilinx/xsetup
cat > run-xilinx.sh <<EOF
#!/bin/bash
. /opt/Xilinx/14.7/ISE_DS/settings64.sh
ise
EOF
```

# Updating the image
```
docker container ls -a
docker commit <hash> xilinx-ise-ubuntu
docker container prune
```

# Running ISE
```
xhost +
docker run --network host --rm -ti -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v $HOME/.Xilinx:/home/xilinx/.Xilinx -v $HOME/src:/home/xilinx/src xilinx-ise-ubuntu /home/xilinx/run-xilinx.sh
```

# Note: Larger Docker Containers

Add dm.basesize=30G" to your /etc/docker/daemon.json.

You'll need to first remove all your docker images, stop the docker service, edit daemon.json, then start docker again.


```
$ sudo cat /etc/docker/daemon.json 
{
  "storage-opt": [ "dm.basesize=20G" ]
}
```

This option **won't** take effect until you remove all your images and start
again, sorry about that :(.

# Note: Mapping USB into docker

`--device=/dev/bus/usb/001/001`
