#!/usr/bin/env bash

trap "ERROR while rebuilding!" ERR

alejandra .
sudo nixos-rebuild --flake .#lwirth-tp switch > nixos-switch.log
./commit-gen.sh
