#!/bin/sh

check() {
python -c '
import os

SYSFS_PATH="/sys/bus/pci/devices"
devs = os.listdir(SYSFS_PATH)
gpus = [ i for i in devs if "0x03000" in open(SYSFS_PATH+"/"+i+"/class").read() ]
_g = (True for i in gpus if "nouveau" in os.path.realpath(SYSFS_PATH+"/"+i+"/driver"))
print(True if True in list(_g) else "")
'
}

if [[ $(check) == True ]];
    then
	# nouveau (see also https://nouveau.freedesktop.org/wiki/Optimus/)
	xrandr --setprovideroffloadsink nouveau Intel;
	# if second gpu output not accessible
	# xrandr --setprovideroutputsource nouveau Intel
    else
	# nvidia
	xrandr --setprovideroutputsource modesetting NVIDIA-0; # not necessarily needed
fi

xrandr --auto;

unset check;
