#!/usr/bin/env bash
# H-B: each extension is served with the correct Content-Type + nosniff header.
set -u
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"
case_setup

echo "H-B  Content types:"
check "index -> text/html"       "text/html"                "$(content_type "${BASE}/")"
check "css   -> text/css"        "text/css"                 "$(content_type "${BASE}/css/custom-body.css")"
check "js    -> text/javascript" "text/javascript"          "$(content_type "${BASE}/js/jquery-3.4.1.min.js")"
check "png   -> image/png"       "image/png"                "$(content_type "${BASE}/images/projectRA.png")"
check "unknown ext -> octet"     "application/octet-stream" "$(content_type "${BASE}/LICENSE")"

nosniff="$(header "X-Content-Type-Options" "${BASE}/css/custom-body.css")"
check "X-Content-Type-Options: nosniff" "nosniff" "${nosniff}"

finish
