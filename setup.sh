#!/usr/bin/env bash
# Copyright 2023 Yongwan Jo

# option --option backup, overwrite
BASE_DIR=$(dirname "$0")/..

LINUX_RC=(
	".bash_aliases"
	".bashrc"
	".gitconfig"
	".profile"
	".vimrc"
	".zshrc"
)

TARGET=--all
if [[ $# -gt 1 ]]; then
	TARGET=$2
fi

display_help()
{
	echo "Usage: $0 <OPTION> <TARGET>" >&2
	echo "  or:  $0 -o --linux : Overwrite current linux shell config" >&2
	echo "  or:  $0 -u  	   : Update to current both config (linux, vscode)" >&2
	echo
	echo "OPTION"
	echo "	 -o, --overwrite 	Overwrite original config to new one "
	echo "	 -u, --update   	Update config to recent one"
	echo "   -b, --backup		Add backup of original one to ./backup"
	echo "	 -h, --help     	Display help message"
	echo "TARGET"
	echo "	 --all,(or empty)  Overwrite/Update both(linux and vscode) settings"
	echo "	 --linux   		   Overwrite/Update linux shell settings"
	echo "   --vscode		   Overwrite/Update vscode settings"
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
		-o | --overwrite)
			case "$TARGET" in
				--linux | --all)
					echo "Replace linux shell config to new one"
					cp -r linux/* ~

					# Move to next step
					if [[ "$TARGET" == '--all' ]]; then
						TARGET='--vscode'
						continue
					else
						break
					fi
					;;
				--vscode)
					echo "Replace vscode config to new one"
					cp vscode/settings.json ~/.config/Code/User
					echo "Replace vscode snippets"
					cp vscode/snippets/* ~/.config/Code/User/snippets

					break
					;;
				*)
					echo "Error: --all, --linux, --vscode or just empty is a valid argument."
					exit 1
			esac
			shift 2
			;;

		-u | --update)
			case "$TARGET" in
				--linux | --all)
					echo "Update repos's linux shell config to new one"
					for config in ${LINUX_RC[*]}; do
						cp ~/$config linux
						echo $config updated
					done

					cp -r ~/.vim linux
					echo ".vim directory updated"

					# Move to next step
					if [[ "$TARGET" == '--all' ]]; then
						TARGET='--vscode'
						continue
					else
						break
					fi
					;;
				--vscode)
					echo "Update repos's vscode config to new one"
					cp  ~/.config/Code/User/settings.json vscode
					echo "Update repos's vscode snippets"
					cp  ~/.config/Code/User/snippets/* vscode/snippets

					break
					;;
				*)
					echo "Error: --all, --linux, --vscode or just empty is a valid argument."
					exit 1
			esac
			shift 2
			;;

		-b | --backup)
			case "$TARGET" in
				--linux | --all)
					echo "Backup original configs in backup directory"
					for config in ${LINUX_RC[*]}; do
						cp ~/$config backup/linux
						echo $config updated
					done

					cp -r ~/.vim backup/linux
					echo ".vim directory updated"

					# Move to next step
					if [[ "$TARGET" == '--all' ]]; then
						TARGET='--vscode'
						continue
					else
						break
					fi
					;;
				--vscode)
					echo "Backup original configs in backup directory"
					cp  ~/.config/Code/User/settings.json backup/vscode
					echo "Backup original configs in backup directory"
					cp  ~/.config/Code/User/snippets/* backup/vscode/snippets

					break
					;;
				*)
					echo "Error: --all, --linux, --vscode or just empty is a valid argument."
					exit 1
			esac
			shift 2
			;;
		*)  # No more options
			echo "Error: Unknown option or argument: $1" >&2
			display_help
			exit 1
			;;
	esac
done

set -eux

# LIBAGAMOTTO=$BASE_DIR/build/libagamotto/libagamotto_nomain.so

# if [[ $SERIALOUT == stdio ]]; then
# 	echo Interactive mode
# 	REDIRECT=
# else
# 	REDIRECT="-serial $SERIALOUT -monitor none"
# fi

# LD_PRELOAD=$LIBAGAMOTTO ${QEMU} \
# 	-smp 1 -m 2G \
# 	-cpu host,-kvmclock \
# 	-enable-kvm \
# 	-kernel $KERNEL \
# 	-hda $IMAGE \
# 	-device qemu-xhci,id=xhci,streams=false,p2=1,p3=0 ${COVDEVICE} \
# 	-append "root=/dev/sda console=ttyS0 earlyprintk=serial dummy_hcd.num=8 oops=panic panic=-1" \
# 	-nographic \
# 	-no-reboot \
# 	-name $QEMU_NAME\
# 	-net $NET $SNAPSHOT $REDIRECT
