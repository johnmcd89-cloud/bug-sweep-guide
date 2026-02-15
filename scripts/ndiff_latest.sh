#!/usr/bin/env bash
set -euo pipefail

# Diff the two most recent nmap XML scans using ndiff.
# Usage: ndiff_latest.sh [scan_dir]

scan_dir="${1:-$HOME/bug-sweep/nmap}"

mapfile -t files < <(ls -1t "$scan_dir"/*.xml 2>/dev/null || true)

if [ ${#files[@]} -lt 2 ]; then
  echo "Need at least two XML scans in $scan_dir" >&2
  exit 1
fi

ndiff "${files[1]}" "${files[0]}" | less
