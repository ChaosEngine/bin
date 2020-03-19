#!/bin/bash

seti@home ()
{
	cwd=`pwd`;
	cd $HOME/BOINC
	#ionice -c3 nice -n 19 /usr/bin/boinc
	ionice -c3 /usr/bin/boinc
	cd $cwd;
}
VirtualBox () 
{ 
	#if [[ $(pgrep docker) ]]; then
	#	echo "docker już działa!";
	#else
	    /usr/bin/ionice -c3 /usr/bin/nice -n 16 /usr/bin/VirtualBox;
	#fi;

    #/usr/bin/VirtualBox shutdown
	#/usr/bin/xset dpms 0 0 600
}
VBoxManage ()
{
	#if [[ $(pgrep docker) ]]; then
	#	echo "docker już działa!";
	#else
		/usr/bin/ionice -c3 /usr/bin/nice -n 16 /usr/bin/VBoxManage "$@"
	#fi;
}
NeedForSpeed ()
{
	cwd=`pwd`;
	cd ~/.wine/drive_c/Program\ Files/Electronic\ Arts/Need\ For\ Speed\ III/;
	wine nfs3.exe -d3d0;
	cd $cwd;
}
Starcraft ()
{
	nice wine ~/.wine/drive_c/Program\ Files/Starcraft/StarCraft.exe;
}
cstrike ()
{
	nice wine ~/.wine/drive_c/Program\ Files/Counter-Strike\ 1.6/cstrike.exe;
}
vncStart ()
{
	if [ "$(pidof Xvnc)" ]; then
		echo "VNC is already running"; return;
	fi
	#vncserver -interface 127.0.0.1 -geometry 1280x800 -localhost -nolisten tcp -autokill;
	vncserver -interface 127.0.0.1 -geometry 1600x900 -localhost -nolisten tcp -autokill;
}
vncStop ()
{
	vncserver -kill :1;
}
startRtorrent()
{
	if [[ $(pgrep rtorrent) ]]; then
		echo rtorrent już działa;
	else
		/bin/su -c rtorrent p2p;
	fi;
}
grochow()
{
	ssh -p 222 -L 5902:localhost:5901 chaos@grochow.hopto.org -t ". /etc/profile; screen -dR"
}
chaosengine()
{
	ssh -p 222 -L 5903:localhost:5901 chaos@chaosengine.tk -t ". /etc/profile; screen -dR"
}
vncE24cloudTwo()
{       
	vncviewer -passwd ~/.vnc/passwd -encodings "tight copyrect" -compresslevel 6 -quality 6 localhost:3 &
	#vncviewer -passwd ~/.vnc/passwd localhost:3 &
}
LightWorks()
{
	LD_PRELOAD=~/usr/lib/libjpeg.so.8.4.0 lightworks;
}
wakeChaos1()
{
	/usr/bin/wakeonlan 00:10:dc:fb:cc:1f
}
wakeArch()
{
	/usr/bin/wakeonlan 50:e5:49:80:b3:19
}
