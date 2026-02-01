PACKAGES += "${PN}-gpulayer"
RDEPENDS:${PN} += "${PN}-gpulayer"

do_install:append() {
    install -d ${D}${GPU_LAYER_LIBDIR}

    for so in ${D}${libdir}/libdrm.so.* ; do
        [ -f "$so" ] || continue
        ln -f "$so" "${D}${GPU_LAYER_LIBDIR}/$(basename $so)"
    done
}

FILES:${PN}-gpulayer += "${GPU_LAYER_LIBDIR}/*"

PRIVATE_LIBS:${PN}-gpulayer = "libdrm.so.2"
