#!/bin/bash

# Show caffeine status

coffee=$(pgrep -f caffeine)

if [ -z "$coffee" ]; then
	echo " ﯈ "
else
	echo "  "
fi

case "$1" in
	-t)
		if [ -z "$coffee" ]; then
			caffeine &
		else
			 kill coffee
		fi
		;;
	*)
esac
