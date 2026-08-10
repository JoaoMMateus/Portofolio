#!/usr/bin/env bash
#
# lib.sh - shared helpers for the portfolio server test suite.
#
# Sourced by tests/run.sh and by every script in tests/cases/.
# Provides: config, assertion helpers, and server lifecycle management so each
# case script can be executed on its own OR orchestrated by run.sh.

# --- Paths -------------------------------------------------------------------
LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"   # .../tests
PROJECT_DIR="$(cd "${LIB_DIR}/.." && pwd)"                # repo root (app-start.js)

# --- Config (override via env) ----------------------------------------------
HOST="${HOST:-localhost}"
PORT="${PORT:-8080}"
BASE="${BASE:-http://${HOST}:${PORT}}"

SERVER_LOG="${SERVER_LOG:-/tmp/portfolio-test-server.log}"
SERVER_PID_FILE="${SERVER_PID_FILE:-/tmp/portfolio-test-server.pid}"

# --- Per-script assertion counters ------------------------------------------
_pass=0
_fail=0

_red()  { printf '\033[31m%s\033[0m' "$1"; }
_grn()  { printf '\033[32m%s\033[0m' "$1"; }

# _record <PASS|FAIL> - append to the shared results file when running under run.sh
_record() { [[ -n "${RESULTS_FILE:-}" ]] && echo "$1" >> "${RESULTS_FILE}"; }

# check <name> <expected> <actual>
check() {
  local name="$1" expected="$2" actual="$3"
  if [[ "${actual}" == "${expected}" ]]; then
    printf '  %s  %s (%s)\n' "$(_grn PASS)" "${name}" "${actual}"
    _pass=$((_pass + 1)); _record PASS
  else
    printf '  %s  %s - expected [%s], got [%s]\n' "$(_red FAIL)" "${name}" "${expected}" "${actual}"
    _fail=$((_fail + 1)); _record FAIL
  fi
}

# check_in <name> <actual> <accepted...> - pass if actual equals any accepted value
check_in() {
  local name="$1" actual="$2"; shift 2
  local a
  for a in "$@"; do
    if [[ "${actual}" == "${a}" ]]; then
      printf '  %s  %s (%s)\n' "$(_grn PASS)" "${name}" "${actual}"
      _pass=$((_pass + 1)); _record PASS
      return 0
    fi
  done
  printf '  %s  %s - expected one of [%s], got [%s]\n' "$(_red FAIL)" "${name}" "$*" "${actual}"
  _fail=$((_fail + 1)); _record FAIL
}

# --- HTTP helpers ------------------------------------------------------------
http_code()    { curl -s -o /dev/null -w "%{http_code}" "$@"; }
body()         { curl -s "$@"; }
content_type() { curl -s -o /dev/null -w "%{content_type}" "$1" | cut -d';' -f1 | tr '[:upper:]' '[:lower:]'; }

# header <name> <curl-args...> -> value (CR-stripped, lowercased, "" if absent)
header() {
  local name="$1"; shift
  curl -s -o /dev/null -D - "$@" | tr -d '\r' \
    | grep -i "^${name}:" | head -1 | cut -d: -f2- | sed 's/^[[:space:]]*//' | tr '[:upper:]' '[:lower:]'
}

# --- Server lifecycle --------------------------------------------------------
server_up() { curl -s -o /dev/null "${BASE}/" 2>/dev/null; }

# Start the server unless one is already answering. Records our PID so we only
# ever stop a server we started (never an unrelated dev server on the port).
start_server() {
  server_up && return 0
  ( cd "${PROJECT_DIR}" && exec node app-start.js ) >"${SERVER_LOG}" 2>&1 &
  echo $! > "${SERVER_PID_FILE}"
  local i
  for i in $(seq 1 30); do
    server_up && return 0
    sleep 0.2
  done
  echo "ERROR: server did not start. Log:" >&2
  cat "${SERVER_LOG}" >&2
  return 1
}

stop_server() {
  [[ -f "${SERVER_PID_FILE}" ]] || return 0
  local pid; pid="$(cat "${SERVER_PID_FILE}" 2>/dev/null)"
  [[ -n "${pid}" ]] && kill "${pid}" 2>/dev/null
  rm -f "${SERVER_PID_FILE}"
}

# Called at the top of each case script. When invoked standalone (not via
# run.sh) it brings a server up and tears it down on exit.
case_setup() {
  if [[ -z "${SUITE_RUNNER:-}" ]]; then
    start_server || exit 1
    trap 'stop_server' EXIT
  fi
}

# Print a per-script summary and return non-zero if any assertion failed.
finish() {
  echo
  if [[ ${_fail} -eq 0 ]]; then
    printf '  %s, 0 failed\n' "$(_grn "${_pass} passed")"
  else
    printf '  %s passed, %s\n' "${_pass}" "$(_red "${_fail} failed")"
  fi
  [[ ${_fail} -eq 0 ]]
}
