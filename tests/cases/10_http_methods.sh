#!/usr/bin/env bash
# Defense-in-depth: the server ignores req.method and serves file bodies for
# every verb. HEAD is fine (Node suppresses the body), but POST/PUT/DELETE/
# OPTIONS ideally should be rejected with 405. Asserting the hardened
# expectation, so these flag as TODOs until method handling is added.
set -u
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"
case_setup

echo "DiD  HTTP method handling:"

# HEAD must return no body (this already holds).
head_bytes="$(curl -s -I "${BASE}/" -o /dev/null -w '%{size_download}')"
check "HEAD / returns empty body" "0" "${head_bytes}"

# Non-GET/HEAD verbs should be rejected.
check "POST /    -> 405" "405" "$(http_code -X POST    "${BASE}/")"
check "PUT /     -> 405" "405" "$(http_code -X PUT     "${BASE}/")"
check "DELETE /  -> 405" "405" "$(http_code -X DELETE  "${BASE}/")"
check "OPTIONS / -> 405" "405" "$(http_code -X OPTIONS "${BASE}/")"

finish
