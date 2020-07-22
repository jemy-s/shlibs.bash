#!/usr/bin/env bash
# Copyright 2019-2020 (c) all rights reserved by SDRausty; see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
# External storage installation: This feature is being developed 
#####################################################################
set -eu
. "$RDR/scripts/bash/shlibs/android/extstck.bash" 
FILEDOSTRING="${0##*/} extstdo.bash"
_EXTSTDO_() {
_CK2EXTSTBD_() {
	( [[ -w "$EXTSTTD/buildAPKs" ]] && printf "%s" "$FILEDOSTRING found writable $EXTSTTD/buildAPKs folder : " && export EXTSTBD=0 ) || ( printf "%s" "$FILEDOSTRING did not detect writable external storage $EXTSTTD/buildAPKs folder : " && _CP2EXTSTTD_ && cd "$EXTSTTD/${RDR##*/}/" && git pull && cd "$RDR" ) && export EXTSTBD=0
	( [[ -f "$EXTSTTD/buildAPKs/.conf/VERSIONID" ]] && ESVERSIONID="$(head -n 1 $EXTSTTD/buildAPKs/.conf/VERSIONID)" && printf "%s" "$FILEDOSTRING found file $EXTSTTD/buildAPKs/.conf/VERSIONID : $ESVERSIONID : " && export EXTSTBD=0 ) || ( printf "%s" "$FILEDOSTRING did not find file $EXTSTTD/buildAPKs/.conf/VERSIONID : " && export EXTSTBD=1 ) 
printf "%s" "EXTSTBD is set to $EXTSTBD : "
printf "%s\\n" "External storage installation : $FILEDOSTRING DONE"
}
_CP2EXTSTTD_() {
	printf "%s" "Copying $RDR/ to $EXTSTTD/ : " && cp -r "$RDR/" "$EXTSTTD/" 2>/dev/null && cp -r "$RDR/.*" "$EXTSTTD/${RDR##*/}/" && printf "%s" "DONE : "
}

( [[ "$EXTSTCK" = 0 ]] && _CK2EXTSTBD_ ) || :
}
( [[ -f  $RDR/.conf/EXTSTDO ]] && EXTSTDO="$(head -n 1 $RDR/.conf/EXTSTDO)" && [[ $EXTSTDO = 0 ]] && _EXTSTCK_ && _EXTSTDO_ ) || :
# extstdo.bash EOF
