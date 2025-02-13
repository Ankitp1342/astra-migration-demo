#!/bin/bash
output="$(ps -ef | grep zdm | grep local | grep -v start_zdm.sh)"
if [$output ne ""]
then
	/usr/local/app/zdm 2&> /usr/local/app/zdm_run.log &
        echo "DONE STARTING ZDM"
else
	echo "ZDM ALREADY STARTED " . $output
fi
