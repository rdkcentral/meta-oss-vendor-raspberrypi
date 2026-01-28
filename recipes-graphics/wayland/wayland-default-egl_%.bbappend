PACKAGES += "wayland-default-egl-gpulayer"
RDEPENDS:wayland-default-egl += "wayland-default-egl-gpulayer"

do_install:append() {
    GPU_LAYER_LIBDIR="${D}/usr/share/gpu-layer/rootfs/usr/lib"
    install -d ${GPU_LAYER_LIBDIR}

    for so in ${D}${libdir}/libwayland-egl.so.* ; do
        [ -f "$so" ] || continue
        ln -f "$so" "${GPU_LAYER_LIBDIR}/$(basename $so)"
    done
}

FILES:wayland-default-egl-gpulayer += "/usr/share/gpu-layer/rootfs/usr/lib/*"

PRIVATE_LIBS:wayland-default-egl-gpulayer = "\
    libwayland-egl.so.1 \
    libwayland-egl.so.1.0.0 \
    "
