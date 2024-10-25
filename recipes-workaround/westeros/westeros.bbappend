# wayland-egl provider for RPi is now changed from wayland to wayland-default-egl.
DEPENDS:append = " wayland-default-egl"
RDEPENDS:${PN}:append = " wayland-default-egl"
