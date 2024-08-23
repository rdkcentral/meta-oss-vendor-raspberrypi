CXXFLAGS_append = "${@bb.utils.contains('DISTRO_FEATURES', 'enable_ermgr', ' -DUSE_ESSRMGR_UDS_IMPL', '', d)}"

# wayland-egl provider for RPi is now changed.
DEPENDS += "wayland-default-egl"
RDEPENDS_${PN} += "wayland-default-egl"
