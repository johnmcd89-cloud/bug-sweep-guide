#!/usr/bin/env bash
set -euo pipefail

# Log a HackRF spectrum sweep to a timestamped CSV.
# Usage: hackrf_sweep_log.sh <start_mhz> <end_mhz> [out_dir]

if [ $# -lt 2 ]; then
  echo "Usage: $0 <start_mhz> <end_mhz> [out_dir]" >&2
  exit 2
fi

start="$1"
end="$2"
out_dir="${3:-$HOME/bug-sweep/rf}"

mkdir -p "$out_dir"

stamp="$(date +%F_%H%M%S)"
out="$out_dir/sweep_${start}_${end}_${stamp}.csv"

# Tune these for your environment:
# -w bin width (Hz)
# -l LNA gain
# -g VGA gain
hackrf_sweep -f "${start}:${end}" -w 1000000 -l 16 -g 20 > "$out"

echo "$out"
