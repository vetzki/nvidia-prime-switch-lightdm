#!/bin/sh

check() {
    lspci -k|grep "Kernel driver in use: nou.*";
    echo $?;
}

if [[ $(check) == 0 ]];
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
