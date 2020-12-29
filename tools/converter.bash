#!/usr/bin/env bash
set -e

parse_openings() {
    local counter=0
    for opening in "${REPOSITORY_ROOT}"/src/*-${LETTER}-*; do
        if ! grep -q '@' "$opening"; then
            continue
        fi
        fen="$(awk -F '@' '/@/ {print $2}' "${opening}")"
        cat \
            "${REPOSITORY_ROOT}/tools/converter-head.txt" \
            "${opening}" \
            "${REPOSITORY_ROOT}/tools/converter-tail.txt" | grep -v 'PGN' | sed -r "s@FEN_BOARD@${fen}@g"
        counter=$((counter+1))
        if ! (( counter % CHESSBOARDS_IN_A_ROW )); then
            echo "\newline"
        else
            echo "\hspace{5mm}"
        fi
    done

    if (( counter % CHESSBOARDS_IN_A_ROW )); then
        echo ""
    fi
}

REPOSITORY_ROOT="$(readlink -f "$(dirname "$(dirname "$0")")")"

CHESSBOARDS_IN_A_ROW="${1:-4}"
TARGET_FILE="$2"
LETTER=$3 # o, s, c or n
SCALEBOX_WIDTH="$(bc -l <<< "2.8/${CHESSBOARDS_IN_A_ROW}" | head -c 4)"
MINIPAGE_WIDTH="$(bc -l <<< "1/${CHESSBOARDS_IN_A_ROW} - 0.025" | head -c 4)"

parse_openings | sed -r \
    -e "s@SCALEBOX_WIDTH@${SCALEBOX_WIDTH}@g" \
    -e "s@MINIPAGE_WIDTH@${MINIPAGE_WIDTH}@g" > "${TARGET_FILE}"