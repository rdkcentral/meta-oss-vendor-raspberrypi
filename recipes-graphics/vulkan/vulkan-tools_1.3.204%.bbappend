FILESEXTRAPATHS:prepend := "${THISDIR}/vulkan-tools:"

inherit pkgconfig

DEPENDS:append = " glslang-native"

SRC_URI:append = " file://0001-cube-build.patch"
SRC_URI:append = " file://0002-cube-xdg-shell.patch"

EXTRA_OECMAKE:append = " -DBUILD_CUBE=ON"
EXTRA_OECMAKE:append = " -DCUBE_WSI_SELECTION=WAYLAND"

PACKAGECONFIG[wayland] = "-DBUILD_WSI_WAYLAND_SUPPORT=ON, -DBUILD_WSI_WAYLAND_SUPPORT=OFF, wayland wayland-protocols wayland-native"
