#!/usr/bin/env bash

# Bomb if anything fails.
set -e

function check_version {
    program=$1
    command=$2
    version=$3

    echo "Checking ${program} version..."
    result=$(eval "docker run shederman/palantirza ${command}")
    if [[ ${result} != *"${version}"* ]]; then
        echo "Error: Expected ${program} ${version}, but got: ${result}" >&2
        exit 1
    else
        echo "Success: Found ${program} ${version}"
    fi
}

# Check the terraform version.
terraform=$(docker run shederman/palantirza terraform -v)
check_version "terraform" "terraform -v" "0.11.3"
check_version "tflint" "tflint -v" "0.5.4"
