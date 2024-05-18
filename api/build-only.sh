#!/bin/bash

my_app_version=$(git describe --tag)

docker compose build --pull --build-arg "MY_APP_VERSION=$my_app_version" # PRN --push silently ignored (on gh standard runner ubuntu-latest) w/ build, suggests a misconfig of builder or smth else (works locally on my mac to build and push AIO)
