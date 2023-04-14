#!/bin/bash
set -e

# Dependency list for building kernel
APT_PACKAGE=(
	"crossbuild-essential-arm64"
	"gcc-aarch64-linux-gnu"
	"qemu-user-binfmt"
	"fakeroot"
	"quilt"
	"dh-exec"
	"libelf-dev"
	"kernel-wedge"
	"device-tree-compiler"
	"libncurses5"
	"libncurses5-dev"
	"build-essential"
	"libssl-dev"
	"mtools"
	"bc"
	"python"
	"python3"
	"dosfstools"
	"bison"
	"flex"
	"rsync"
	"u-boot-tools"
	"make"
)

# Install dependency via apt
echo Installing ${APT_PACKAGE[*]}
apt-get install -y ${APT_PACKAGE[*]}
