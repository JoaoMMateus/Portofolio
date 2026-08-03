#!/usr/bin/env bash
# H-A: classic path traversal must be blocked, and /etc/passwd must not leak.
set -u
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"
case_setup

echo "H-A  Path traversal:"
check "raw ../ traversal        -> 403" "403" \
  "$(http_code --path-as-is "${BASE}/../../../../../../etc/passwd")"
check "encoded %2e%2e traversal -> 403" "403" \
  "$(http_code "${BASE}/%2e%2e%2f%2e%2e%2f%2e%2e%2fetc%2fpasswd")"

leak="$(curl -s --path-as-is "${BASE}/../../../../../../etc/passwd")"
if echo "${leak}" | grep -q "root:.*:0:0:"; then
  check "no /etc/passwd contents leaked" "no-leak" "LEAKED"
else
  check "no /etc/passwd contents leaked" "no-leak" "no-leak"
fi

finish
