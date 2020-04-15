# Pokemon Deck Wizard

## ship-it script dependencies

- shellcheck: to lint bash scripts
- docker: to build application's docker image

## local k8s deployment dependencies

- local k8s cluster
- export DOCKER_ACCOUNT=local
- export CIRCLE_BUILD_NUM=0

## lessons learned

- run k8s manifest against local k8s cluster to find basic problems, it takes a long time to find 
small problems one at a time going throug the CI/CD pipeline

## circle ci env variables

### Docker Hub Registry

- DOCKER_ACCOUNT
- DOCKER_PASS
- DOCKER_USER

### Kubernetes Cluster

- K8S_ACCESS_TOKEN
- K8S_CLUSTER_SERVER
