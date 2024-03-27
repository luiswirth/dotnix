#!/usr/bin/env bash

trap "ERROR while rebuilding!" ERR

alejandra .
sudo nixos-rebuild --flake .#lwirth-tp switch > nixos-switch.log
gen=$(nixos-rebuild --flake .#lwirth-tp list-generations | grep current)
git commit -am "$gen"
