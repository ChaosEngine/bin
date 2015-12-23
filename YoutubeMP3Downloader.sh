#!/bin/bash
#
############variables############
MPATH=${1:-"/home/ftp/muzyka dla mamy"};
WRKPATH="/tmp/ytbdwnld_"$USER"_work"
LOCKFILE="/tmp/ytbdwnld_"$USER"_run.lock"
YTB="/usr/bin/youtube-dl"
#YTB="echo youtube-dl $@"
XRGS="/usr/bin/xargs"

##########functions###############
fileProcess()
{
	cd "$MPATH";
	ytbid=$($YTB --simulate --skip-download --no-playlist --no-post-overwrites --get-id "$1");
	if [ ! -e $ytbid ] && [ $( ls *$ytbid* | wc -l) -ge 1 ]; then
		echo "exists [$ytbid] skipping";
	else
		echo "not exists [$ytbid] downloading and converting";
		$YTB --extract-audio --audio-format mp3 --rate-limit 2.0M --no-playlist --no-post-overwrites --no-overwrites "$1"
	fi
}
LockfileChecking()
{
	if [ -f $LOCKFILE ]; then
        	echo "$0: Already running, exiting..."
	        exit 1
	fi
	touch "$LOCKFILE";
	rm -rf "$WRKPATH";
	if [[ ! -d "$WRKPATH" ]]; then
		mkdir "$WRKPATH";
	fi
}

export -f fileProcess
export YTB
export MPATH
###########body##########
LockfileChecking;

cd "$WRKPATH";

shopt -s nocaseglob;
for myfile in "$MPATH/"*.txt
do
	if [[ -f $myfile ]]; then
		echo "Processing file [$myfile]";
		grep "^http" "$myfile" | uniq | $XRGS -P 0 -n 1 -I{} bash -c fileProcess\ \{\}
	fi

done

##########cleaning#############
#wait
unset -v MPATH
unset -v YTB
unset -f fileProcess
rm -rf "$WRKPATH";
rm -f "$LOCKFILE";
exit 0;
