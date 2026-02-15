#!/usr/bin/env bash
set -euo pipefail

# Run an nmap inventory scan and save XML output.
# Usage: nmap_inventory.sh <cidr> [out_dir]

if [ $# -lt 1 ]; then
  echo "Usage: $0 <cidr> [out_dir]" >&2
  exit 2
fi

cidr="$1"
out_dir="${2:-$HOME/bug-sweep/nmap}"
mkdir -p "$out_dir"

stamp="$(date +%F_%H%M%S)"
out="$out_dir/scan_${stamp}.xml"

sudo nmap -sV -O -oX "$out" "$cidr"

echo "$out"
