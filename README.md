# ACQ400CSS + docker + cs-studio

This repo creates a docker ubuntu image and installs cs-studio into it

New workspaces can be generated from the new_workspace.sh script

## How to install
### Linux 
1) First install docker:
	[Supported platforms](https://docs.docker.com/engine/install/#supported-platforms)

	Install through distro package manager do not use snap

2) Clone this repo:
	```
	git clone https://github.com/sambelltacq/ACQ400CSS_docker
	```
3) Create new workspace:
	```
	./workspaces/new_workspace.sh acq2106_123
	```
4) Run cs-studio
	```
	./cs-studio_docker.sh
	```
	First time setup might take a while

### Windows

TODO

DOCKERDESKTOP + VcXsrv?
