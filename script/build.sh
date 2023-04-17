#!/bin/bash
set -e

# Set path to simplify command
PATH="$PATH:./build"
PATH="/tmp/extract/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin:$PATH"

# Make kernel for Rock Pi 5B, rk3588
# Maybe not required as packing implies building
mk-kernel.sh rk3588-rock-5b

# Set package revision
REVISION="${99:-$REVISION}"

# Pack kernel for Debian
pack-kernel.sh -d rockchip_linux_defconfig -r $REVISION
