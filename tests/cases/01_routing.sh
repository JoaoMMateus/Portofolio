#!/usr/bin/env bash
# Baseline routing sanity: known routes resolve to the right pages.
set -u
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"
case_setup

echo "Routing (sanity):"
check "GET /            -> 200" "200" "$(http_code "${BASE}/")"
check "GET /m           -> 200" "200" "$(http_code "${BASE}/m")"
check "GET /index.html  -> 200" "200" "$(http_code "${BASE}/index.html")"
check "GET /certifications.html        -> 200" "200" "$(http_code "${BASE}/certifications.html")"
check "GET /certifications-mobile.html -> 200" "200" "$(http_code "${BASE}/certifications-mobile.html")"

finish
