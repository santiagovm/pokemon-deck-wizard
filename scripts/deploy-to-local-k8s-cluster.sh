#!/usr/bin/env bash

WHITE_COLOR_CODE='\033[0;37m'
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

function show_section_title() {
  echo -e "${GREEN_COLOR_CODE}\\n[----- $1 -----]\\n${WHITE_COLOR_CODE}"
}

function build_project() {
  show_section_title "building project"
  ./gradlew
}

function create_docker_image() {
  show_section_title "creating docker image"
  docker build --tag="$DOCKER_ACCOUNT/pokemon-deck-wizard:0.1.$CIRCLE_BUILD_NUM" .
}

function prepare_k8s_manifest_template() {
  show_section_title "preparing k8s manifest"
  rm -rf .k8s/.generated && mkdir -p .k8s/.generated
  manifest=".k8s/manifest-templates/ci.yml"
  eval "echo \"$(sed 's/"/\\"/g' $manifest)\"" > ".k8s/.generated/$(basename $manifest)"
}

function deploy_to_local_k8s_cluster() {
  show_section_title "deploying to local k8s cluster"
  kubectl config use-context docker-desktop
  kubectl apply -f .k8s/.generated/ --validate=true
  kubectl get pods --namespace pdw-ci-namespace
}

function main() {
  set_bash_fail_on_error
  go_to_root_directory
  check_scripts
  build_project
  create_docker_image
  prepare_k8s_manifest_template
  deploy_to_local_k8s_cluster
}

main "$@"
