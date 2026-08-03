#!/usr/bin/env bash
# GAP: symlink escape. The traversal guard is lexical (startsWith ROOT), but
# fs.readFile follows symlinks. A symlink INSIDE the web root that points
# OUTSIDE it stays "inside" lexically, so a request through it can read an
# outside file. Secure behavior: reject (403/404) and never serve the target.
#
# NOTE: expected to FAIL against the current lexical-only guard - that failure
# is the finding. The fix is fs.realpath() + re-check against ROOT.
set -u
. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../lib.sh"
case_setup

echo "GAP  Symlink escape:"

secret_dir="$(mktemp -d /tmp/portfolio-outside.XXXXXX)"
echo "SYMLINK-SECRET-$$" > "${secret_dir}/secret.txt"
link_path="${PROJECT_DIR}/__symtest_link"
ln -sfn "${secret_dir}" "${link_path}"

code="$(http_code "${BASE}/__symtest_link/secret.txt")"
resp="$(curl -s "${BASE}/__symtest_link/secret.txt")"

# Cleanup the planted symlink and outside dir regardless of outcome.
rm -f "${link_path}"
rm -rf "${secret_dir}"

check_in "request through symlink blocked (403/404)" "${code}" "403" "404"
if echo "${resp}" | grep -q "SYMLINK-SECRET-$$"; then
  check "symlink target not leaked" "no-leak" "LEAKED"
else
  check "symlink target not leaked" "no-leak" "no-leak"
fi

finish
