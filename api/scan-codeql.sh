#!/bin/bash

# git clone https://github.com/github/codeql.git ~/repos/github/github/codeql

rm -rf codeql-db
codeql database create  --language=csharp --source-root=./ codeql-db
codeql database analyze codeql-db --format=csv --output=w00t.csv --rerun ~/repos/github/github/codeql/csharp/ql/src/Security\ Features/CWE-798/HardcodedCredentials.ql

echo
echo
echo "## running query to dump explanation tables"
echo
codeql query run --database codeql-db ~/repos/github/github/codeql/csharp/ql/src/Security\ Features/CWE-798/HardcodedCredentials.ql
