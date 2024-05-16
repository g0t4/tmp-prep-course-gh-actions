#!/bin/sh
set -e

APP_NAME=upper
OUTPUT_DIR=bin

platforms=("windows/amd64" "linux/amd64" "darwin/amd64")

mkdir -p $OUTPUT_DIR

for platform in "${platforms[@]}"
do
    platform_split=(${platform//\// })
    GOOS=${platform_split[0]}
    GOARCH=${platform_split[1]}
    output_name=$OUTPUT_DIR/$APP_NAME'-'$GOOS'-'$GOARCH
    if [ $GOOS = "windows" ]; then
        output_name+='.exe'
    fi

    echo "Building $output_name..."
    env GOOS=$GOOS GOARCH=$GOARCH go build -o $output_name .
done

