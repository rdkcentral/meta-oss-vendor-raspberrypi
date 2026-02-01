PACKAGES += "${PN}-gpulayer"
RDEPENDS:${PN} += "${PN}-gpulayer"

do_install:append() {
    GPU_LAYER_LIBDIR="${D}/usr/share/gpu-layer/rootfs/usr/lib"
    install -d ${GPU_LAYER_LIBDIR}

    for so in ${D}${libdir}/libwayland-egl.so.* ; do
        [ -f "$so" ] || continue
        ln -f "$so" "${GPU_LAYER_LIBDIR}/$(basename $so)"
    done
}

FILES:${PN}-gpulayer += "/usr/share/gpu-layer/rootfs/usr/lib/*"

PRIVATE_LIBS:${PN} += "libwayland-egl.so.1"
