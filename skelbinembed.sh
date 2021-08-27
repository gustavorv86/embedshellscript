#!/bin/bash

_G_SCRIPTNAME=$0
_G_BEGINPAYLOAD=BEGINPAYLOAD

_m_extract_payload() {
	extractfile=$1

	sed -e "1,/__${_G_BEGINPAYLOAD}__/d" $_G_SCRIPTNAME | base64 --decode > $extractfile
	if [ ! -f $extractfile ]; then
		return 1
	fi
	
	extractsha1sum=`/usr/bin/sha1sum $extractfile | cut -d " " -f 1`
	if [ "$extractsha1sum" == "$SHA1SUMFILE" ]; then
		return 0
	else
		return 2
	fi
}

################      EDIT SECTION      ################

## Path to extract file.
EXTRACTFILE='/tmp/extractedfile.bin'

## SHA1 from original file.
SHA1SUMFILE='ffffffffffffffffffffffffffffffffffffffff'

main() {

	## Use $1..$N command line arguments.

	_m_extract_payload $EXTRACTFILE
	status=$?
	if [ $status -eq 1 ]; then
		echo "ERROR: cannot extract payload."
	elif [ $status -eq 2 ]; then
		echo "ERROR: invalid SHA1 extracted file."
	else
		echo "INFO: file $EXTRACTFILE is OK."
	fi

	## Use the extracted file here.

	return 0
}

################    END EDIT SECTION    ##############

main $@
exit $?

__BEGINPAYLOAD__
