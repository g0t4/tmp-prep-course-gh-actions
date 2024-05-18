#!/bin/bash

# get ref? or can I pass the expected version here? maybe put smoke test into cd-deploy workflow?
reported_version=$(curl -fsSL "http://gh-actions-web-api.azurewebsites.net/version")
echo "Reported version: $reported_version"

# TODO can I inject this from context of deploy trigger?
latest_version=$(git describe --tag)
echo "Latest version: $latest_version"

echo "Check if version matches:"
if [ "$reported_version" != "$latest_version" ]; then
  echo "  [FAIL] version mismatch"
  exit 1
fi
echo "  [PASS]"
