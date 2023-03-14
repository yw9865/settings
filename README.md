# Collection of my own commands aliases including vscode setting.

Last few days, I spent quite lots of time for setting my own environments. I feel to need the copies of my setting files so that avoid some waste of time. I hope I don't have to waste my time again.

## Manual for `setup.sh`
You can use `setup.sh` for updating or applying some config files.

### Allow script to run on system
```
chmod +x setup.sh
```

### Make backup before overwrite
Follow the stpes below. You should make directory before run `setup.sh` for copying.
```
mkdir backup
mkdir backup/linux
mkdir backup/vscode
mkdir backup/vscode/snippets
```
After making directory, you can make copies using below commands.
```
./setup.sh -b            # empty option (or --all) copies both (linux+vscode) configs.
./setup.sh -b --linux	 # -l (linux) only copies linux configs.
./setup.sh -b --vscode	 # -v (vscode) only copies vscode configs and snippets.
```
You don't have to run all of those commands.

### Apply configs to yours
```
./setup.sh -o            # empty option (or --all) overwrites both (linux+vscode) configs.
./setup.sh -o --linux	 # -l (linux) only overwrites linux configs.
./setup.sh -o --vscode	 # -v (vscode) only overwrites vscode configs and snippets.
```
### Update repository to new one
```
./setup.sh -u            # empty option (or --all) updates both (linux+vscode) configs.
./setup.sh -u --linux	 # -l (linux) only updates linux configs.
./setup.sh -u --vscode	 # -v (vscode) only updates vscode configs and snippets.
```
### You can get help from `setup.sh`
#### input
```
./setup.sh --help
```
#### output
```
Usage:  ./setup.sh <OPTION> <TARGET>
 e.g.:  ./setup.sh -o --linux    : Overwrite current linux shell config
   or:  ./setup.sh -u            : Update to current both config (linux, vscode)

OPTION:
         -o, --overwrite        Overwrite original config to new one
         -u, --update           Update config to recent one
         -b, --backup           Add backup of original one to ./backup
         -h, --help             Display help message
TARGET:
         --all,(or empty)  Overwrite/Update both(linux and vscode) settings
         --linux                   Overwrite/Update linux shell settings
         --vscode                  Overwrite/Update vscode settings
```
## If you have any question or want to contribute,
Please contact me through github or 70959544+yw9865@users.noreply.github.com
