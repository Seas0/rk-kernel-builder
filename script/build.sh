#!/bin/bash
set -e

# Set path to simplify command
PATH="$PATH:./build"

# Make kernel for Rock Pi 5B, rk3588
# Maybe not required as packing implies building
mk-kernel.sh rk3588-rock-5b

# Set package revision
REVISION="${99:-$REVISION}"

# Pack kernel for Debian
pack-kernel.sh -d rockchip_linux_defconfig -r $REVISION
