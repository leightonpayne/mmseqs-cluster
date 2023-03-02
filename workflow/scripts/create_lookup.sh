#!/usr/bin/env bash

sequenceDB="${1}"
targetDB="${2}"
ext="${3:-}"

while read key offset length; do
	lookup=$(grep "^${key}\t" "${sequenceDB}.lookup")
	while read key id x; do
		if [[ "${ext}" != "" ]]; then
			echo -e "${key}\t${id}.${ext}\t${x}"
		else
			echo -e "${key}\t${id}\t${x}"
		fi
	done < <(echo ${lookup})
done < "${targetDB}.index" > "${targetDB}.lookup"
