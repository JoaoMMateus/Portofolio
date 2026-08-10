#!/usr/bin/env bash
# GAP: null-byte / truncation. A "%00" in the path decodes to a NUL, which
# fs.readFile rejects by THROWING synchronously - and the throw is uncaught,
# so the server process crashes (unauthenticated DoS). Secure behavior: reject
# with a 4xx and keep serving.
#
# NOTE: expected to FAIL against the current code (it crashes). The runner
# restarts the server for subsequent test files.
set -u
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"
case_setup

echo "GAP  Null-byte / truncation:"

code1="$(http_code "${BASE}/%00")"
check_in "GET /%00 handled (4xx, not crash)" "${code1}" "400" "403" "404"

# Give the process a moment, then confirm it is still serving.
sleep 0.3
if server_up; then
  check "server still alive after /%00" "alive" "alive"
else
  check "server still alive after /%00" "alive" "CRASHED"
fi

# Truncation variant: NUL in the middle of an otherwise-valid name.
code2="$(http_code "${BASE}/index.html%00.txt")"
check_in "GET /index.html%00.txt handled (4xx)" "${code2}" "400" "403" "404"

finish
