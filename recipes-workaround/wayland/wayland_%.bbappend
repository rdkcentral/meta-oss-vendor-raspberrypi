# Only works with OSS release 3.0.3 since the wayland.bbappend
# was customized to provide wayland-default-egl from OSS.

RDEPENDS:${PN}-dev += "${PN}-default-egl-dev"
