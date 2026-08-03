#!/usr/bin/env bash
# H-D: directory requests and missing files resolve to 404 (no crash, no listing).
set -u
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"
case_setup

echo "H-D  Directory / error handling:"
check "directory /css     -> 404" "404" "$(http_code "${BASE}/css")"
check "directory /images  -> 404" "404" "$(http_code "${BASE}/images")"
check "missing file       -> 404" "404" "$(http_code "${BASE}/does-not-exist.html")"

finish
