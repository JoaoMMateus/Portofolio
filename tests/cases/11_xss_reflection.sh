#!/usr/bin/env bash
# Regression guard: the 404/403 error responses are static and must never
# reflect the requested path (no reflected XSS). Expected to pass.
set -u
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"
case_setup

echo "DiD  XSS reflection in errors:"

payload="/%3Cscript%3Ealert(1)%3C%2Fscript%3E"   # /<script>alert(1)</script>
resp="$(curl -s "${BASE}${payload}")"

if echo "${resp}" | grep -qi "<script"; then
  check "path not reflected in error body" "no-reflection" "REFLECTED"
else
  check "path not reflected in error body" "no-reflection" "no-reflection"
fi

finish
