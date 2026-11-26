#!/bin/bash -xv
# SPDX-FileCopyrightText: 2026 Hayato Tsunoda
# SPDX-License-Identifier: BSD-3-Clause

ng () {
	echo "${1}行目が違うよ"
	res=1
}

res=0

### PLUS NORMAL INPUT ###
out=$(seq 5 | ./plus)
[ "${out}" = 15 ] || ng "$LINENO"

### PLUS STRANGE INPUT ###
out=$(echo あ | ./plus)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo | ./plus)
[ "$?" = 1 ]      || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

### PWCHECK NORMAL INPUT ###
out=$(printf '12345\nAbc12345\nAbc123!@#xyz\n' | ./pwcheck)
expected=$(printf 'WEAK: 12345\nMEDIUM: Abc12345\nSTRONG: Abc123!@#xyz')
[ "${out}" = "${expected}" ] || ng "$LINENO"

### PWCHECK OPTIONS ###
out=$(printf '12345\nAbc12345\nAbc123!@#xyz\n' | ./pwcheck --strong-only)
[ "${out}" = "Abc123!@#xyz" ] || ng "$LINENO"

out=$(printf 'Abc123!@#xyz\n' | ./pwcheck -m 15)
[ "${out}" = "WEAK: Abc123!@#xyz" ] || ng "$LINENO"

### PWCHECK STRANGE INPUT ###
out=$(printf '\n' | ./pwcheck 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo 'abc' | ./pwcheck -m 0 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

out=$(echo 'abc' | ./pwcheck -m invalid 2>/dev/null)
[ "$?" = 2 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK
exit $res
