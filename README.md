# ACQ400CSS + docker + cs-studio

This repo creates a docker ubuntu image and installs cs-studio into it

Workspaces are stored in the workspaces dir

do not run workspace_init.sh

## How to install
### Linux 
1) First install docker:
	[Supported platforms](https://docs.docker.com/engine/install/#supported-platforms)

	Install through distro package manager do not use snap

2) Clone this repo:
	```
	git clone https://github.com/sambelltacq/ACQ400CSS_docker
	cd ACQ400CSS_docker
	```
3) Run cs-studio
	```
	with hostname
	./cs-studio_docker.sh acq2106_123

	with hostname and static ip 
	./cs-studio_docker.sh acq2106_123 10.12.1.123

	diy setup
	./cs-studio_docker.sh
	```
	First time setup might take a while

	if using static ip must delete any previous workspaces

4) *BONUS* Install on path
	```
	#create link
	sudo ln -s $(pwd)/cs-studio_docker.sh /usr/local/bin/cs-studio

	#run from anywhere
	cs-studio acq2106_123
	```


### Windows

TODO

DOCKERDESKTOP + VcXsrv?
