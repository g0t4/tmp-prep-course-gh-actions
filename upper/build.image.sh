#!/bin/bash

# docker image build --platform=linux/amd64 -t upper .
docker image build -t upper .

# usage:
#   docker container run -i -t --rm  upper:latest foo the bar