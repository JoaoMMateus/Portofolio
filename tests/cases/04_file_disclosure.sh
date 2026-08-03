#!/usr/bin/env bash
# H-C: a file OUTSIDE the web root must never be served, even though files
#      inside the root are served by design.
set -u
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"
case_setup

echo "H-C  File disclosure:"
secret_file="$(mktemp /tmp/portfolio-secret.XXXXXX)"
echo "TOP-SECRET-$$" > "${secret_file}"
ups="$(printf '../%.0s' $(seq 1 12))"   # enough ../ to reach filesystem root

secret_code="$(http_code --path-as-is "${BASE}/${ups}${secret_file}")"
secret_resp="$(curl -s --path-as-is "${BASE}/${ups}${secret_file}")"
rm -f "${secret_file}"

check "outside-root file    -> 403" "403" "${secret_code}"
if echo "${secret_resp}" | grep -q "TOP-SECRET-$$"; then
  check "outside-root file not leaked" "no-leak" "LEAKED"
else
  check "outside-root file not leaked" "no-leak" "no-leak"
fi

finish
