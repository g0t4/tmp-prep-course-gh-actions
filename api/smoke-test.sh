#!/bin/bash

# USAGE:
#    ./smoke-test.sh 4e2e816a664b81ee95fbe31737ea758edf3aaa4d    # check if this commit is released
#    ./smoke-test.sh    # check if latest commit is released

# head_sha comes from workflow_run event payload, this is the version that was built/deployed
head_sha=$1 # first arg is ${{ github.event.workflow_run.head_sha }}
expected_version=$(git describe --tags $head_sha)
echo "Expected version (was deployed): $expected_version"

actual_version=$(curl -fsSL "http://gh-actions-web-api.azurewebsites.net/version")
echo "Actual version: $actual_version"

echo "Check if version matches:"
if [ "$actual_version" != "$expected_version" ]; then
  echo "  [FAIL] version mismatch"
  exit 1
fi
echo "  [PASS]"
