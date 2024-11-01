#!/usr/bin/env sh

trap 'echo "ERROR while rebuilding!"; exit -1' ERR

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 {switch|boot}"
  exit 1
fi

MODE=$1
case $MODE in
  switch|boot)
    alejandra .
    sudo nixos-rebuild --flake .#lwirth-tp $MODE |& nom
    ./commit-gen.sh
    ;;
  *)
    echo "Invalid argument: $MODE. Use 'switch' or 'boot'."
    exit 1
    ;;
esac
