#!/usr/bin/env bash
# Copyright 2020 (c) all rights reserved by S D Rausty; See LICENSE
# File `doso.bash` is under development
#####################################################################
set -Eeuo pipefail
shopt -s nullglob globstar
. "$RDR"/scripts/bash/shlibs/trap.bash 175 176 177 "${0##*/} doso.bash" 
printf "%s\\n" "File \`doso.bash\` is being developed."
_FUNZIP_()
{
	echo "zip -r -u "$PKGNAM.apk" "${APP%/*}/lib""
	zip -r -u "$PKGNAM.apk" "${APP%/*}/lib"
	echo "zip -r -u "$PKGNAM.apk" "${APP%/*}/lib": done"
}
declare CPUABI=""
CPUABI="$(getprop ro.product.cpu.abi)" 
declare -A AMKARR # associative array
# populate target architecture directory structure:
# PRSTARR=([arm64-v8a]=lib/arm64-v8a [armeabi-v7a]=lib/armeabi-v7a [x86]=lib/x86 [x86_64]=lib/x86_64)
printf "%s\\n" "Found $CPUABI architecture.  Searching for \`CMakeLists.txt\` files;  Please be patient..."
AMKFS=($(find "$JDR" -type f -name CMakeLists.txt)) 
# AMKFS=($(find "$JDR" -type f -name Android.mk -or -name CMakeLists.txt))
if [[ -z "${AMKFS[@]:-}" ]]
then
	echo "No CMakeLists.txt files found."
else
	for FAMK in ${AMKFS[@]}
	do
		echo 
		echo $FAMK 
		echo
	done
	for FAMK in ${AMKFS[@]}
	do 
		if [[ $(echo $FAMK) = 0 ]]
		then
			printf "%s\\n" "0 Android.mk files found."
		else
			printf "%s\\n" "Found $FAMK."
			cd  "${FAMK%/*}" 
			printf "Beginning cmake && make in %s/.\\n" "$PWD"
			cmake . || printf "%s\\n" "Signal 42 gernerated in cmake ${0##*/} doso.bash"
			make || printf "%s\\n" "Signal 44 gernerated in make ${0##*/} doso.bash"
			SOARR=($(ls | egrep '\.o$|\.so$')) || printf "%s\\n" "Signal 46 gernerated in SOAR ${0##*/} doso.bash"
			if [[ -z "${SOARR[@]:-}" ]]
			then
				printf "%s\\n" "0 *.o and *.so files were found;  There is nothing to do."
			else
				mkdir -p "${APP%/*}/lib/armeabi-v7a"
				for i in ${SOARR[@]}
				do
					printf "Copying %s to %s/." "$i" "${APP%/*}/lib/armeabi-v7a"
					cp "$i" "${APP%/*}/lib/armeabi-v7a" || printf "%s\\n" "Signal 48 gernerated in mv ${i##*/} ${0##/*} doso.bash" 
				done
			fi
			printf "\\nFinishing cmake && make in %s/.\\n" "$PWD"
			cd  "${APP%/*}"
			printf "Change directory to %s/.\\n\\n" "$PWD"
		fi
	done
fi
# doso.bash EOF