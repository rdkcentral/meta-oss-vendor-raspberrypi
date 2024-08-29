# This recipe's intended to provide only the wayland-egl.so and related pkgconfig
# due to the non-standard wayland package delivery from OSS layer.
# Refer: ./common/meta-rdk-oss-reference/recipes-graphics/wayland/wayland_%.bbappend

HOMEPAGE = "http://wayland.freedesktop.org"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING;md5=b31d8f53b6aaf2b4985d7dd7810a70d1 \
                    file://src/wayland-server.c;endline=24;md5=b8e046164a766bb1ede8ba38e9dcd7ce"

DEPENDS = "wayland"
RDEPENDS_${PN} = "wayland"

SRC_URI = "https://wayland.freedesktop.org/releases/wayland-${PV}.tar.xz \
    file://CMakeLists.txt \
    "

SRC_URI[md5sum] = "23317697b6e3ff2e1ac8c5ba3ed57b65"
SRC_URI[sha256sum] = "4675a79f091020817a98fd0484e7208c8762242266967f55a67776936c2e294d"

UPSTREAM_CHECK_URI = "https://wayland.freedesktop.org/releases.html"

S = "${WORKDIR}/wayland-${PV}/egl"

PV ?= "1.18.0"
PR ?= "r0"

inherit cmake pkgconfig

do_configure_prepend() {
    cp ${WORKDIR}/CMakeLists.txt ${S}
}

# Only add ./common/meta-rdk-oss-reference/recipes-graphics/wayland/wayland_%.bbappend removed files
FILES_${PN} = "${libdir}/libwayland-egl.so* ${libdir}/pkgconfig/wayland-egl.pc"
FILES_${PN}-dev = "${libdir}/libwayland-egl.so ${libdir}/pkgconfig/wayland-egl.pc"
FILES_${PN}-dbg += "${libdir}/.debug"

INSANE_SKIP_${PN} = "dev-so ldflags dev-elf"

