FROM ubuntu:24.04
# TODO arg for base tag

# based on: https://hub.docker.com/_/ubuntu
#   24.04 23.10 22.04 20.04 etc

# THINK pack your app in an image:
#   maybe use this to run tests of your app in different distro envs
  RUN apt update && apt install -y python3 icdiff fish
# each major release of ubuntu has a diff python/icdiff version so could demo that to show the final variance too

ENTRYPOINT [ "fish" ]


# PERHAPS create an image with the go static app (that said, less of a need for a distro-base... go makes more sense in distroless image)