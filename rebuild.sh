#!/usr/bin/env bash

trap "ERROR while rebuilding!" ERR

alejandra .
git diff -U0 *.nix
echo "NixOS Rebuilding..."
sudo nixos-rebuild --flake .#lwirth-tp switch > nixos-switch.log || (
  cat nixos-switch.log | grep --color error && false)
gen=$(nixos-rebuild --flake .#lwirth-tp list-generations | grep current)
git commit -am "$gen"
