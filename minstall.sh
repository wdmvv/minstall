#!/bin/bash

cfgsetup()
{
	cd ~;
	touch .mincfg;
	printf "~/Desktop" > .mincfg;
}

hflag()
{
	printf "Script that allows you to download any Mindustry version. Flags:\n\t -p - change download path and run\n\t -h - display this message\n\t -d - display download path\nUsage:\n\t./minstall.sh -p [yourpathhere]\n"
}

dflag()
{
	cd ~;
	echo $(sed '1!d' .mincfg)
}

main()
{
	cd ~;
	read -p "Mindustry version: " ver;
	path=$(sed '1!d' .mincfg)
	cd $path;
	wget -q --show-progress https://github.com/Anuken/Mindustry/releases/download/v"$ver"/Mindustry.jar;
	echo "Downloaded Mindustry v"$ver" at "$path""
}

while getopts "p:hd" opt; do
	case $opt in
		p) {
			if ! [ -f ~/.mincfg ];
			then cfgsetup
			fi
			cd ~;
			echo "$OPTARG" > .mincfg;
			} 
			main ;;
		h) hflag ;;
		d) dflag ;;
		*) main
	esac
done
