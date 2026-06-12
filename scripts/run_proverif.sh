#!/usr/bin/env bash
# Run ProVerif on bundled models; write logs + wall seconds to formal/proverif/out/
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PV="$ROOT/formal/proverif"
OUT="$PV/out"
mkdir -p "$OUT"
command -v proverif >/dev/null || { echo "Install proverif (see formal/proverif/README.md)" >&2; exit 1; }

run_one() {
  local f="$1"
  local base
  base="$(basename "$f" .pv)"
  echo "Running ProVerif on $f ..."
  local start=$SECONDS
  # Applied pi calculus (.pv with process/query) requires -in pitype
  proverif -in pitype "$f" | tee "$OUT/${base}.log"
  echo $((SECONDS - start)) >"$OUT/${base}.time_s.txt"
}

run_one "$PV/examples/minimal_secrecy.pv"
run_one "$PV/sdt_abstract.pv"
run_one "$PV/sdt_signed_pipeline.pv"
echo "Done."
