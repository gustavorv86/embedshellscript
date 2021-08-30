#!/bin/bash

_G_SCRIPTNAME=$0

_fn_extract_payload() {
	local extractfile=$1

	local payloadline=`grep -n "__PAYLOAD__" $_G_SCRIPTNAME | tail -n1 | cut -d ":" -f 1`
	local payloadline=$(($payloadline + 1))
	tail -n +${payloadline} $_G_SCRIPTNAME | base64 -d > $extractfile

	if [ ! -f $extractfile ]; then
		return 1
	fi

	return 0	
}

################      EDIT SECTION      ################

_main() {

	## Use $1..$N command line arguments.

	local extractfile=`mktemp "/tmp/extractfile.XXXXXXXXXXXXXXXXXXXXXXXX"`

	_fn_extract_payload $extractfile
	local status=$?
	if [ $status -ne 0 ]; then
		echo "ERROR: cannot extract payload."
		return 1
	fi

	## Use the extracted file here.

	echo "INFO: tarball SHA1:"
	sha1sum ./tarball.tar.xz
	echo

	echo "INFO: extracted file SHA1:"
	sha1sum $extractfile
	echo

	echo "INFO extract file content:"
	tar -tvf $extractfile
	echo

	rm -f $extractfile

	return 0
}

################    END EDIT SECTION    ##############

_main $@
exit $?

__PAYLOAD__
/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4Cf/AJZdADoZSs4gAOk2j6zmg68mJ34hqZzGQFnPgsMG
WAN7D9tTWZqKYB0vsD9U0rdWgrtV6OeAUP5d82755P8yhsb2I8K0MY3NnF2LiONg8Ud1rhEL/uF8
8QJuiyH3h9gZiLBrQYqS2a3jOxvvC+EPH45tDjTMMNUJ29alWLqoFnnZrz4qikvjkJb+lSO35c0u
rxqAhss54bFUAAAAAMtIq6Ct1CGZAAGyAYBQAACY19IoscRn+wIAAAAABFla
