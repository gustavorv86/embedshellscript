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

	#chmod u+x $extractfile
	#$extractfile

	#rm -f $extractfile

	return 0
}

################    END EDIT SECTION    ##############

_main $@
exit $?

__PAYLOAD__
