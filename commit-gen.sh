#!/usr/bin/env sh
gen=$(nixos-rebuild --flake .#lwirth-tp list-generations | grep current)
git commit -am "$gen"
