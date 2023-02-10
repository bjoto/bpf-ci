#!/bin/bash
set -eu

source $(cd $(dirname $0) && pwd)/../helpers.sh

foldable start install_cross_compiler "Installing cross-compilation GCC and libraries"

sudo sed -i 's/^deb/deb [arch=amd64]/g' /etc/apt/sources.list

sudo dpkg --add-architecture riscv64
cat <<EOF | sudo tee -a /etc/apt/sources.list
deb [arch=riscv64 signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports $(lsb_release -c -s) main
deb [arch=riscv64 signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports $(lsb_release -c -s)-updates main
deb [arch=riscv64 signed-by="/usr/share/keyrings/ubuntu-archive-keyring.gpg"] http://ports.ubuntu.com/ubuntu-ports $(lsb_release -c -s)-security main
EOF

sudo apt-get update
sudo apt-get install --yes --no-install-recommends \
     g++-riscv64-linux-gnu \
     gcc-riscv64-linux-gnu


sudo apt-get install --yes --no-install-recommends \
	libasound2-dev:riscv64 \
	libc6-dev:riscv64 \
	libcap-dev:riscv64 \
	libcap-ng-dev:riscv64 \
	libelf-dev:riscv64 \
	libmnl-dev:riscv64 \
	libnuma-dev:riscv64 \
	libpopt-dev:riscv64

foldable end install_cross_compiler
