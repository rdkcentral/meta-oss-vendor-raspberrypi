CXXFLAGS:append = "${@bb.utils.contains('DISTRO_FEATURES', 'enable_ermgr', ' -DUSE_ESSRMGR_UDS_IMPL', '', d)}"

# wayland-egl provider for RPi is now changed from wayland to wayland-default-egl.
DEPENDS:append = " wayland-default-egl"
RDEPENDS:${PN}:append = " wayland-default-egl"
