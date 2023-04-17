#!/bin/bash
set -e

# Apply patch
for s in source/patch/*; do
  for p in $s/*.patch; do
    patch -N -s -p1 -d $(basename $s) < "$p"
  done
done