#!/usr/bin/env bash

# set up temporary files for muscle i/o
in_tmp=$(mktemp /tmp/muscle_in.XXXXXXXX)
out_tmp=$(mktemp /tmp/muscle_out.XXXXXXXX)
# clean up the temp files later
trap "rm -f ${in_tmp}; rm -f ${out_tmp}" ERR INT EXIT

# send stdin (from `mmseqs apply`) to temporary input
cat /dev/stdin > "${in_tmp}"

max_align="${1}"
nseq=$(grep -c '^>' "${in_tmp}")
if [[ "${nseq}" -le "${max_align}" ]]; then
  muscle -align "${in_tmp}" -output ${out_tmp}
  # send temporary output (from `muscle`) to stdout
  cat "${out_tmp}"
elif [[ "${nseq}" -gt "${max_align}" ]]; then
  muscle -super5 "${in_tmp}" -output ${out_tmp}
  cat "${out_tmp}"
else
  cat "${in_tmp}"
fi
