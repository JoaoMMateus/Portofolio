#!/usr/bin/env bash
# Defense-in-depth: recommended security headers should be present on HTML
# responses. They are absent today, so these assert "present" and will FAIL as
# actionable TODOs until the headers are added to app-start.js.
set -u
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"
case_setup

echo "DiD  Hardening headers on / :"

present() { [[ -n "$1" ]] && echo present || echo absent; }

check "Content-Security-Policy present" "present" \
  "$(present "$(header "Content-Security-Policy" "${BASE}/")")"
check "X-Frame-Options present"        "present" \
  "$(present "$(header "X-Frame-Options" "${BASE}/")")"
check "Referrer-Policy present"        "present" \
  "$(present "$(header "Referrer-Policy" "${BASE}/")")"
check "Permissions-Policy present"     "present" \
  "$(present "$(header "Permissions-Policy" "${BASE}/")")"

finish
