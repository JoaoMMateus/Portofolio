#!/usr/bin/env bash
# GAP checks: alternate traversal encodings must all stay confined to ROOT
# (403 = rejected by guard, 404 = resolved to a non-existent in-root path).
# Neither may return file contents. Regression guard - expected to pass.
set -u
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"
case_setup

echo "GAP  Alternate traversal encodings:"

check_in "..%2f (encoded slash)   confined" \
  "$(http_code --path-as-is "${BASE}/..%2f..%2f..%2f..%2f..%2fetc%2fpasswd")" "403" "404"
check_in "..%5c (backslash)       confined" \
  "$(http_code "${BASE}/..%5c..%5c..%5c..%5cetc%5cpasswd")" "403" "404"
check_in "....// (nested dots)    confined" \
  "$(http_code --path-as-is "${BASE}/....//....//....//....//etc/passwd")" "403" "404"
check_in "leading //etc/passwd    confined" \
  "$(http_code --path-as-is "${BASE}//etc/passwd")" "403" "404"
check_in "raw /etc/passwd         confined" \
  "$(http_code --path-as-is "${BASE}/etc/passwd")" "403" "404"

# None of the above may leak the real /etc/passwd.
leaked="no-leak"
for u in "/..%2f..%2f..%2f..%2f..%2fetc%2fpasswd" "//etc/passwd" "/etc/passwd"; do
  if curl -s --path-as-is "${BASE}${u}" | grep -q "root:.*:0:0:"; then leaked="LEAKED"; fi
done
check "no variant leaks /etc/passwd" "no-leak" "${leaked}"

finish
