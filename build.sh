#!/usr/bin/env bash

VENV_DIR=".venv"
BUILD_DIR="dist/build_function_zip"
# TARGET="../function.zip" # TODO misleading; this is relative from BUILD_DIR

pushd lambda1

[[ ! -d "${VENV_DIR}" ]] && virtualenv "${VENV_DIR}"
POETRY_VIRTUALENVS_IN_PROJECT=true poetry install --only main --sync

rm -rf "${BUILD_DIR}"
mkdir -p "${BUILD_DIR}"
cp -r "${VENV_DIR}"/lib/python3*/site-packages/* "${BUILD_DIR}"/
cp -r lambda1/* "${BUILD_DIR}/"

# TODO tf does this now, but we could build here and push to s3 etc. instead
# pushd "${BUILD_DIR}"
# zip -r --filesync "${TARGET}" .
# popd

popd
