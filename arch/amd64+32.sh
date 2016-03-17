#!/bin/bash
##arch/amd64+32.sh: Build definitions for +32 packages of amd64 arch, i.e. i686 pkgs (optenv only).
##@copyright GPL-2.0+
CFLAGS_COMMON_ARCH='-march=pentium4 -mtune=core2 -msse -msse2 -msse3 '
HOSTTOOLPREFIX=/opt/32/bin/i686-pc-linux-gnu
export PKG_CONFIG_DIR=/opt/32/lib/pkgconfig
unset LDFLAGS_COMMON_CROSS_BASE
