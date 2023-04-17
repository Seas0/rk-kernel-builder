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
	"wget"
)

DOWNLOAD_DIR="/tmp/download/"
DOWNLOAD_LIST=(
	"https://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/aarch64-linux-gnu/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu.tar.xz"
	#"https://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/aarch64-linux-gnu/runtime-gcc-linaro-7.5.0-2019.12-aarch64-linux-gnu.tar.xz"
	#"https://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/aarch64-linux-gnu/sysroot-glibc-linaro-2.25-2019.12-aarch64-linux-gnu.tar.xz"
)
EXTRACT_DIR="/usr/local/"

# Install dependencies via apt
echo -e "\e[32mInstalling\e[0m \e[33m${APT_PACKAGE[*]}\e[0m"
apt-get update -qq
apt-get install -q -y ${APT_PACKAGE[*]}

# Download dependencies
mkdir -p "$DOWNLOAD_DIR" "$EXTRACT_DIR"
for f in ${DOWNLOAD_LIST[*]}; do
	echo -e "\e[32mDownloading\e[0m \e[33m$(basename $f)\e[0m"
	wget -q -c -P "$DOWNLOAD_DIR" "$f" &
done
wait
for f in ${DOWNLOAD_LIST[*]}; do
	echo -e "\e[32mExtracting\e[0m \e[33m$(basename $f)\e[0m"
	tar xJf "$DOWNLOAD_DIR/$(basename $f)" -C "$EXTRACT_DIR" &
done
wait
chmod -R go=u-w "$EXTRACT_DIR"
for f in ${DOWNLOAD_LIST[*]}; do
	echo -e "\e[31mDeleting\e[0m \e[33m$(basename $f)\e[0m"
	rm -f "$DOWNLOAD_DIR/$(basename $f)" &
done
wait
rm -rf "$DOWNLOAD_DIR"
echo -e '\e[32mDone\e[0m'