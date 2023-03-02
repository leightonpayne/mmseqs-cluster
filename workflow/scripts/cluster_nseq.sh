#!/usr/bin/env bash

nseq=$(grep -c "^>" /dev/stdin)
echo -e "${MMSEQS_ENTRY_NAME}\t${nseq}"
