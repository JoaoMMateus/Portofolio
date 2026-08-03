#!/usr/bin/env bash
#
# run.sh - main test runner for the portfolio HTTP server.
#
# Starts app-start.js once, executes every script in tests/cases/ (each is a
# self-contained, individually runnable test), then stops the server and prints
# an aggregate summary. Resurrects the server between cases in case a test
# crashes it (e.g. the null-byte DoS check).
#
# Usage:
#   ./tests/run.sh                 # run the whole suite
#   ./tests/cases/08_null_byte.sh  # run a single test on its own
#
# Exit code: 0 if all assertions pass, 1 otherwise.

set -u

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
. "${DIR}/lib.sh"

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is required but not installed." >&2
  exit 1
fi
if ! command -v node >/dev/null 2>&1; then
  echo "node is required but not installed." >&2
  exit 1
fi

export SUITE_RUNNER=1
RESULTS_FILE="$(mktemp)"; export RESULTS_FILE
: > "${RESULTS_FILE}"

cleanup() {
  stop_server
  rm -f "${RESULTS_FILE}"
}
trap cleanup EXIT INT TERM

echo "Starting server for suite..."
start_server || exit 1
echo "Running suite against ${BASE}"
echo

case_files_failed=0
for f in "${DIR}"/cases/*.sh; do
  [[ -e "${f}" ]] || continue
  echo "=== $(basename "${f}") ==="
  # A previous case may have crashed the server (see the null-byte test) - revive it.
  server_up || start_server || { echo "  (could not restart server)"; }
  bash "${f}" || case_files_failed=$((case_files_failed + 1))
  echo
done

passed="$(grep -c '^PASS$' "${RESULTS_FILE}" 2>/dev/null || true)"
failed="$(grep -c '^FAIL$' "${RESULTS_FILE}" 2>/dev/null || true)"
passed="${passed:-0}"; failed="${failed:-0}"

echo "=================================================="
if [[ "${failed}" -eq 0 ]]; then
  printf 'ALL GREEN - %s assertions passed across all test files.\n' "${passed}"
else
  printf 'Assertions: %s passed, %s FAILED  (%s test file(s) reported failures)\n' \
    "${passed}" "${failed}" "${case_files_failed}"
fi

[[ "${failed}" -eq 0 ]]
