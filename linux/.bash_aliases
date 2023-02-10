clean-path() { echo $(printf %s "$1" | awk -vRS=: '!a[$0]++' | paste -s -d:); }
PATH=$(clean-path "/usr/local/lib/python3.8/dist-packages/bin:$PATH")

# nano default option views line number
alias nano='nano -c'

# Compile macro
comp() { g++ -O2 $1.cpp -o $1; }

# Disable file overwrite
alias mv='mv -iv'
alias cp='cp -iv'
alias rm='rm -v'

# ASM
alias objdump='objdump -zd -M intel --visualize-jumps=extended-color --insn-width=15'
alias diasm='objdump --no-show-raw-insn'
alias disasm-raw='objdump --visualize-jumps=off --insn-width=8 -j .rodata -j .data'

#dump <elf> <.section> <dext path>
dump() { objcopy --dump-section $2=$3 $1; }

alias assemble='gcc -nostdlib -static'
mkshell() { assemble $1.s -o $1; dump $1 '.text' "$1.bin"; }

# Template file
_templates='/home/yw9865/.pwn_template'
mkasm() { [[ ! -e $1 ]] && cp "${_templates}/asm.s" $1 || echo 'Error'; }
mkpwn() { [[ ! -e $1 ]] && cp "${_templates}/pwn.py" $1 || echo 'Error'; }

# Lookup constant values
lookup() { grep -r "#[ \t]*define[ \t]* $1" /usr/include; }

# connect ctf ssh
alias pwncollege='ssh yonsei@yonsei.pwn.college'

# alias python=python3
alias python=python3

# test code
debug() { gcc $1 ; ./a.out; }

# run new zsh
alias nzsh='gnome-terminal --window-with-profile=zsh'

# git custom commands
alias git-short='git log --format=short --abbrev-commit --name-only'
