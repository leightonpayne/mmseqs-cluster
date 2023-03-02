#!/usr/bin/env bash

clustercount=${1}
keyfile=${2}

while read key nseq; do
	if [[ "${nseq}" -ge 5 ]]; then
		echo -e "${key}"
	fi
done < <(tr -d '\0' < ${clustercount}) > ${keyfile}
