#!/usr/bin/env bash
# Copyright 2023 Yongwan Jo

# option --option backup, overwrite

BASE_DIR=$(dirname "$0")/..

QEMU=${BASE_DIR}/build/qemu/install/bin/qemu-system-x86_64
KERNEL=${BASE_DIR}/build/guest/linux/image/usb/arch/x86_64/boot/bzImage
IMAGE=./buster.img
NET="none"
COVDEVICE=""
SNAPSHOT=""
SERIALOUT=stdio

display_help()
{
	echo "Usage: $0 -i <image file>" >&2
	echo "  or:  $0 -O OVERLAY" >&2
	echo "  or:  $0 -h"
	echo
	echo "OPTION"
	echo "	 -i, --image <image file>	Run qemu with <image file>"
	echo "	 -O, --overlay OVERLAY  	Run qemu with buster-overlay-?.img (OVERLAY is described below)"
	echo "   -C, --cov			Add a coverage collection device and dump coverage to a file specified using this option"
	echo "   -H, --hwsim			Select a mac80211_hwsim-enabled kernel"
	echo "	 -o, --out <log file> 	        Redirect qemu's output to <log file>"
	echo "   -P, --persistent		Persist modifications to the image"
	echo "   -S, --snapshot			Do not persist modifications to the image"
	echo "	 -h, --help             	Display help message"
}

while true; do
	if [ $# -eq 0 ];then
		break
	fi

	case "$1" in
		-h | --help)
			display_help
			exit 0
			;;
		-i | --image)
			IMAGE=./$2
			shift 2
			;;
		-O | --overlay)
			case "$2" in
				0)
					IMAGE=./buster-overlay-0.img
					NET="none"
					QEMU_NAME=0
					;;
				1)
					IMAGE=./buster-overlay-1.img
					NET="none"
					QEMU_NAME=1
					;;
				2)
					IMAGE=./buster-overlay-2.img
					#NET="nic -net user,hostfwd=tcp::10022-:22"
					NET="none"
					QEMU_NAME=2
					;;
				3)
					IMAGE=./buster-overlay-3.img
					NET="none"
					QEMU_NAME=1
					;;
				4)
					IMAGE=./buster-overlay-4.img
					NET="none"
					QEMU_NAME=2
					;;
				5)
					IMAGE=./buster-overlay-5.img
					NET="none"
					QEMU_NAME=1
					;;
				6)
					IMAGE=./buster-overlay-6.img
					NET="none"
					QEMU_NAME=2
					;;
				7)
					IMAGE=./buster-overlay-7.img
					NET="none"
					QEMU_NAME=1
					;;
				8)
					IMAGE=./buster-overlay-8.img
					NET="none"
					QEMU_NAME=2
					;;
				*)
					echo "Error: Only 0 to 8 is a valid argument of -O option"
					exit 1
			esac
			shift 2
			;;
		-P | --persistent)
			SNAPSHOT=
			shift 1
			;;
		-S | --snapshot)
			SNAPSHOT="-snapshot"
			shift 1
			;;
		-C | --cov)
			COVDEVICE=" -device kcov_vdev,trace-pc=on,dump-path=$2"
			KERNEL=${BASE_DIR}/build/guest/linux/image/usbcov/arch/x86_64/boot/bzImage
			shift 2
			;;
		-H | --hwsim)
			# override
			KERNEL=${BASE_DIR}/build/guest/linux/image/machwsim/arch/x86_64/boot/bzImage
			shift 1
			;;
		-o | --out)
			SERIALOUT="file:$2"
			shift 2
			;;
		*)  # No more options
			echo "Error: Unknown option or argument: $1" >&2
			display_help
			exit 1
			;;
	esac
done

rm -f /tmp/agamotto/device-*
sudo chown -R ${USER}:${USER} /dev/bus/usb/001/*

set -eux

LIBAGAMOTTO=$BASE_DIR/build/libagamotto/libagamotto_nomain.so

if [[ $SERIALOUT == stdio ]]; then
	echo Interactive mode
	REDIRECT=
else
	REDIRECT="-serial $SERIALOUT -monitor none"
fi

LD_PRELOAD=$LIBAGAMOTTO ${QEMU} \
	-smp 1 -m 2G \
	-cpu host,-kvmclock \
	-enable-kvm \
	-kernel $KERNEL \
	-hda $IMAGE \
	-device qemu-xhci,id=xhci,streams=false,p2=1,p3=0 ${COVDEVICE} \
	-append "root=/dev/sda console=ttyS0 earlyprintk=serial dummy_hcd.num=8 oops=panic panic=-1" \
	-nographic \
	-no-reboot \
	-name $QEMU_NAME\
	-net $NET $SNAPSHOT $REDIRECT
