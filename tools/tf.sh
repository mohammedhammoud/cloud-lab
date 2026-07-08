#!/usr/bin/env bash
set -euo pipefail

PROJECT="${1:-}"
ACTION="${2:-plan}"

if [ -z "$PROJECT" ]; then
  echo "Usage: tools/tf.sh <project-name> [init|fmt|validate|plan|apply|destroy]"
  echo "Example: tools/tf.sh 01-s3-basics plan"
  exit 1
fi

TF_DIR="projects/$PROJECT/terraform"

if [ ! -d "$TF_DIR" ]; then
  echo "Terraform directory not found: $TF_DIR"
  exit 1
fi

cd "$TF_DIR"

case "$ACTION" in
  init)
    terraform init
    ;;
  fmt)
    terraform fmt
    ;;
  validate)
    terraform init
    terraform validate
    ;;
  plan)
    terraform fmt
    terraform init
    terraform validate
    terraform plan
    ;;
  apply)
    terraform fmt
    terraform init
    terraform validate
    terraform apply
    ;;
  destroy)
    terraform init
    terraform destroy
    ;;
  *)
    echo "Unknown action: $ACTION"
    echo "Allowed: init, fmt, validate, plan, apply, destroy"
    exit 1
    ;;
esac
