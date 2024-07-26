# ACQ400CSS + docker + cs-studio

This repo creates a docker ubuntu image and installs cs-studio into it

Workspaces are stored in the workspaces dir

A single script "./cs-studio_docker.sh" creates the cs-studio instance and per-uut workspace.

## How to install
### Linux 
1) First install docker:
	[Supported platforms](https://docs.docker.com/engine/install/#supported-platforms)

	Install through distro package manager do not use snap

2) Clone this repo:
	```
	git clone https://github.com/D-TACQ/ACQ400CSS_docker
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
	First time setup might take a while. 
    cs-studio may complain on first start .. see: [starting-first-workspace-step-by-step.pdf](starting-first-workspace-step-by-step.pdf)

	if using static ip please delete any previous workspaces

4) *BONUS* Install on path
	```
	#create link
	sudo ln -s $(pwd)/cs-studio_docker.sh /usr/local/bin/cs-studio

	#run from anywhere
	cs-studio acq2106_123
	```


### Windows

1) Install docker desktop:
	[Docker Desktop](https://docs.docker.com/desktop/install/windows-install/)

2) Install git:
	[Git for windows](https://git-scm.com/download/win)

3) Install VcXsrv:
	[VcXsrv](https://sourceforge.net/projects/vcxsrv/)

4) Open powershell or cmd

5) Clone this repo:
	```
	git clone https://github.com/sambelltacq/ACQ400CSS_docker
	cd ACQ400CSS_docker
	```
	
5) Run cs-studio
	```
	with hostname
	./cs-studio_docker.sh acq2106_123

	with hostname and static ip 
	./cs-studio_docker.sh acq2106_123 10.12.1.123

	diy setup
	./cs-studio_docker.sh
	```
	First time setup might take a while
