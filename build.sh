#!/usr/bin/env bash

set -e

LAMBDA_NAME="$1"

VENV_DIR=".venv"
BUILD_DIR="dist/build_function_zip"
# TARGET="../function.zip" # TODO misleading; this is relative from BUILD_DIR

if [[ -z "$LAMBDA_NAME" ]]; then
  echo "Error: Missing parameter." >&2; echo "Usage: $0 <lambda_name>"; exit 1
fi

pushd "${LAMBDA_NAME}" || (echo "meow" && exit)

#rm -rf "${VENV_DIR}"
rm -rf "${BUILD_DIR}"

virtualenv "${VENV_DIR}" --no-pip --no-setuptools --no-wheel --clear
source "${VENV_DIR}"/bin/activate
POETRY_VIRTUALENVS_IN_PROJECT=true poetry install --only main --sync
deactivate

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"
cp -r "${VENV_DIR}"/lib/python3*/site-packages/* "${BUILD_DIR}"/
cp -r "${LAMBDA_NAME}"/* "${BUILD_DIR}/"

# TODO tf does this now, but we could build here and push to s3 etc. instead
# pushd "${BUILD_DIR}"
# zip -r --filesync "${TARGET}" .
# popd

popd || (echo "roar" && exit)
