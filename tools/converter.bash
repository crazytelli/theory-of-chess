#!/usr/bin/env bash
set -e

repo_root="$(readlink -f "$(dirname "$(dirname "$0")")")"

{
	counter=0
	for opening in "${repo_root}"/src/*-o-*; do
		if ! (( counter % 4 )); then
			echo "\begin{figure}[H]"
		fi
		cat \
			"${repo_root}/tools/converter-head.txt" \
			"${opening}" \
			"${repo_root}/tools/converter-tail.txt"
		counter=$((counter+1))
		if ! (( counter % 4 )); then
			echo "\end{figure}"
			echo ""
		fi
	done

	if (( counter % 4 )); then
		echo "\end{figure}"
		echo ""
	fi
} > "${repo_root}/src/open.tex"
