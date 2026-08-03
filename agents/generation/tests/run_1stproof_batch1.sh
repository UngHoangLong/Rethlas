#!/usr/bin/env bash
# Runs all 10 First Proof batch-1 problems through run_example.sh sequentially.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

SUMMARY_LOG="${SUMMARY_LOG:-$ROOT_DIR/logs/1stproof_batch1_summary.log}"
mkdir -p "$(dirname "$SUMMARY_LOG")"

echo "=== 1stProof batch-1 run started at $(date -u +%FT%TZ) ===" | tee -a "$SUMMARY_LOG"

for i in $(seq -w 1 10); do
  problem_file="data/1stproof_batch1/problem_${i}.md"
  echo "" | tee -a "$SUMMARY_LOG"
  echo "########## problem_${i} — started $(date -u +%FT%TZ) ##########" | tee -a "$SUMMARY_LOG"

  if PROBLEM_FILE="$problem_file" ./tests/run_example.sh 2>&1 | tee -a "$SUMMARY_LOG"; then
    echo "########## problem_${i} — finished OK $(date -u +%FT%TZ) ##########" | tee -a "$SUMMARY_LOG"
  else
    rc=$?
    echo "########## problem_${i} — FAILED (exit $rc) $(date -u +%FT%TZ) ##########" | tee -a "$SUMMARY_LOG"
  fi
done

echo "" | tee -a "$SUMMARY_LOG"
echo "=== 1stProof batch-1 run finished at $(date -u +%FT%TZ) ===" | tee -a "$SUMMARY_LOG"
