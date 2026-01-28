PACKAGES += "${PN}-gpulayer"
RDEPENDS:${PN} += "${PN}-gpulayer"

do_install:append() {
    GPU_LAYER_LIBDIR="${D}/usr/share/gpu-layer/rootfs/usr/lib"
    install -d ${GPU_LAYER_LIBDIR}

    for so in \
        ${D}${libdir}/libwayland-client.so.* \
        ${D}${libdir}/libwayland-server.so.* ; do
        [ -f "$so" ] || continue
        ln -f "$so" "${GPU_LAYER_LIBDIR}/$(basename $so)"
    done
}

FILES:${PN}-gpulayer += "/usr/share/gpu-layer/rootfs/usr/lib/*"

PRIVATE_LIBS:${PN}-gpulayer = "\
    libwayland-server.so.0.20.0 \
    libwayland-server.so.0 \
    libwayland-client.so.0.20.0 \
    libwayland-client.so.0 \
    "
