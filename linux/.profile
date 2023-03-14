# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# add go path
export PATH=$PATH:/usr/local/go/bin

# add GOPATH
go env -w GOPATH=$HOME/Workspace/go
export GOPATH=$(go env GOPATH)

# add AGPATH
export AGPATH=$HOME/Workspace/2d-agamotto

# add python path
export PATH=/usr/bin/python3:$PATH

export PATH=$AGPATH/build/qemu/install/bin:$PATH

export LD_LIBRARY_PATH=$AGPATH/build/libagamotto:$LD_LIBRARY_PATH

# add TRPATH
export TRPATH=$HOME/Workspace/2d-agamotto-traces

# add FZPATH
export FZPATH=$AGPATH/syzkaller/workdir.cysec/fuzz-agamotto-usb

# add Syzkaller path
export SZPATH=$GOPATH/src/github.com/google/syzkaller

# add guest kernel path
export KRPATH=$AGPATH/guest/linux/kernel

# prepend TeX live to Path
export PATH=$PATH:/usr/local/texlive/2022/bin/x86_64-linux
