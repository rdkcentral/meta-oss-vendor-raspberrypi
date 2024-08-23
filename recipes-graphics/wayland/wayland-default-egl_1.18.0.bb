# This recipe's intended to provide only the wayland-egl.so and related pkgconfig
# due to the non-standard wayland package delivery from OSS layer.
# Refer: ./common/meta-rdk-oss-reference/recipes-graphics/wayland/wayland_%.bbappend

HOMEPAGE = "http://wayland.freedesktop.org"
LICENSE = "CLOSED"

DEPENDS = "expat libffi wayland-native"

# Extend the path to include the FILESEXTRAPATH of original recipe
FILESEXTRAPATHS_prepend := "${COREBASE}/meta/recipes-graphics/wayland/wayland:"

SRC_URI = "https://wayland.freedesktop.org/releases/wayland-${PV}.tar.xz \
    file://0002-meson.build-find-the-native-wayland-scanner-directly.patch \
    "

SRC_URI[md5sum] = "23317697b6e3ff2e1ac8c5ba3ed57b65"
SRC_URI[sha256sum] = "4675a79f091020817a98fd0484e7208c8762242266967f55a67776936c2e294d"

UPSTREAM_CHECK_URI = "https://wayland.freedesktop.org/releases.html"

S = "${WORKDIR}/wayland-${PV}"

inherit meson pkgconfig

EXTRA_OEMESON = "-Ddocumentation=false -Ddtd_validation=false"
EXTRA_OEMESON_class-native = "-Ddocumentation=false -Dlibraries=false"

RDEPENDS_${PN} = " wayland "

PACKAGES = "${PN} ${PN}-dev ${PN}-dbg"

do_install_append() {
    rm -rf ${D}/usr/share
    rm -rf ${D}/usr/bin
    rm -rf ${D}/usr/include
    rm -rf ${D}/usr/include
    rm -rf ${D}/usr/lib/libwayland-client.*
    rm -rf ${D}/usr/lib/libwayland-cursor.*
    rm -rf ${D}/usr/lib/libwayland-server.*
    rm -rf ${D}/usr/share/wayland
    rm -rf ${D}/usr/share/aclocal
    rm -rf ${D}/usr/lib/pkgconfig/wayland-client.pc
    rm -rf ${D}/usr/lib/pkgconfig/wayland-cursor.pc
    rm -rf ${D}/usr/lib/pkgconfig/wayland-scanner.pc
    rm -rf ${D}/usr/lib/pkgconfig/wayland-egl-backend.pc
    rm -rf ${D}/usr/lib/pkgconfig/wayland-server.pc
}

# Only add ./common/meta-rdk-oss-reference/recipes-graphics/wayland/wayland_%.bbappend removed files
FILES_${PN} = "${libdir}/libwayland-egl.so* ${libdir}/pkgconfig/wayland-egl.pc"
FILES_${PN}-dev = "${libdir}/libwayland-egl.so ${libdir}/pkgconfig/wayland-egl.pc"
FILES_${PN}-dbg += "${libdir}/.debug"

INSANE_SKIP_${PN} = "dev-so ldflags dev-elf"

