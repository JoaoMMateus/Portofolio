#!/usr/bin/env bash
# Regression guard: responses must not advertise the stack via X-Powered-By or
# a revealing Server header. Node's core http sets neither by default - this
# locks that in so a future framework/change can't silently reintroduce it.
set -u
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"
case_setup

echo "DiD  Info-leak headers:"

absent_if_empty() { [[ -z "$1" ]] && echo absent || echo "present:$1"; }

check "no X-Powered-By header" "absent" \
  "$(absent_if_empty "$(header "X-Powered-By" "${BASE}/")")"
check "no revealing Server header" "absent" \
  "$(absent_if_empty "$(header "Server" "${BASE}/")")"

finish
