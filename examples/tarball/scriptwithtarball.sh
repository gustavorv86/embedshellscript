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
EXTRACTFILE='/tmp/extracted.tar.xz'

## SHA1 from original file.
SHA1SUMFILE='1d9dfe8c94b69419398dc09801f404550b2b87a7'

main() {

	_m_extract_payload $EXTRACTFILE
	status=$?
	if [ $status -eq 1 ]; then
		echo "ERROR: cannot extract payload."
	elif [ $status -eq 2 ]; then
		echo "ERROR: invalid SHA1 extracted file."
	else
		echo "INFO: file $EXTRACTFILE is OK."
	fi

	echo
	echo "Original tarball SHA1:"
	sha1sum ./tarball.tar.xz

	echo
	echo "Extracted tarball SHA1:"
	sha1sum $EXTRACTFILE

	echo
	echo "Extracted tarball file:"
	file $EXTRACTFILE
	ls -l $EXTRACTFILE

	echo
	echo "Show extracted tarball content:"
	tar tvf $EXTRACTFILE
	echo

	return 0
}

################    END EDIT SECTION    ##############

main $@
exit $?

__BEGINPAYLOAD__
/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4Cf/AJZdADoZSs4gAOk2j6zmg68mJ34hqZzGQFnPgsMG
WAN7D9tTWZqKYB0vsD9U0rdWgrtV6OeAUP5d82755P8yhsb2I8K0MY3NnF2LiONg8Ud1rhEL/uF8
8QJuiyH3h9gZiLBrQYqS2a3jOxvvC+EPH45tDjTMMNUJ29alWLqoFnnZrz4qikvjkJb+lSO35c0u
rxqAhss54bFUAAAAAMtIq6Ct1CGZAAGyAYBQAACY19IoscRn+wIAAAAABFla
