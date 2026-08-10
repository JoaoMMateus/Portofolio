#!/usr/bin/env bash
# GAP check: double URL-encoding (%252e%252e%252f...). The server decodes
# exactly once, so this should remain a literal path segment (404) and must NOT
# become a working traversal. Regression guard - expected to pass.
set -u
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"
case_setup

echo "GAP  Double URL-encoding:"
url="${BASE}/%252e%252e%252f%252e%252e%252f%252e%252e%252fetc%252fpasswd"
check "double-encoded ../ -> 404 (not traversal)" "404" "$(http_code "${url}")"

resp="$(curl -s "${url}")"
if echo "${resp}" | grep -q "root:.*:0:0:"; then
  check "double-encoding does not leak /etc/passwd" "no-leak" "LEAKED"
else
  check "double-encoding does not leak /etc/passwd" "no-leak" "no-leak"
fi

finish
