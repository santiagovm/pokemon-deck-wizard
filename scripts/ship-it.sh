#!/usr/bin/env bash

RED_COLOR_CODE='\033[0;31m'
GREEN_COLOR_CODE='\033[0;32m'

function set_bash_fail_on_error() {
  set -o errexit
  set -o errtrace
  set -o nounset
  set -o pipefail
}

function go_to_root_directory() {
  root_directory=$(git rev-parse --show-toplevel)
  cd "$root_directory"
}

function check_scripts() {
  shellcheck scripts/*.sh
}

function build_project() {
  ./gradlew
}

function purge_local_database() {
  echo -e "[purge_local_database] not implemented yet"
}

function e2e_tests() {
    echo -e "[e2e_tests] not implemented yet"
}

function fail_for_unstaged_files() {
    local -r unstaged_files_count=$(git status --porcelain | wc -l)
    local -r trimmed_unstaged_files_count=$(echo -e -n "$unstaged_files_count" | tr -d ' ')

    if [ "$trimmed_unstaged_files_count" != "0" ]; then
        local -r unstaged_files=$(git status --porcelain)
        echo -e "${RED_COLOR_CODE}\\nERROR!\\nUnstaged and/or uncommitted files found! 😱\\nPlease clean these up and try again:\\n${unstaged_files}"
        return 1
    fi
}

function push_code() {
    git push
}

function display_ascii_success_message() {
    echo -e "${GREEN_COLOR_CODE}\\n$(cat scripts/success_ascii_art.txt)"
}

function main() {
  set_bash_fail_on_error
  go_to_root_directory
  check_scripts
  build_project
  purge_local_database
  e2e_tests
  fail_for_unstaged_files
  push_code
  display_ascii_success_message
}

main "$@"
