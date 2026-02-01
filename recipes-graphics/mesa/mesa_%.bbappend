# RDKE-96: virtual/egl and related mesa provided packages are failing to link in inter layer build.
# RCA: mesa recipe does not include them in mesa-dev package but all the below mentioned packages are
# mapped against mesa.
# PREFERRED_PROVIDER_virtual/egl, PREFERRED_PROVIDER_virtual/libgl, PREFERRED_PROVIDER_virtual/libgles2 and
# PREFERRED_PROVIDER_virtual/libgbm
# Ref: https://github.com/rdkcentral/meta-product-raspberrypi/pull/21

RDEPENDS:${PN}-dev += " \
    libegl-mesa-dev \
    libgl-mesa-dev \
    libglapi-dev \
    libgbm-dev \
    libgles1-mesa-dev \
    libgles2-mesa-dev \
    libgles3-mesa-dev \
    "

PACKAGES += "${PN}-gpulayer"
RDEPENDS:libegl-mesa += "${PN}-gpulayer"

do_install:append() {
    install -d ${D}${GPU_LAYER_LIBDIR}

    for so in \
        ${D}${libdir}/libEGL.so.* \
        ${D}${libdir}/libGLESv2.so.* \
        ${D}${libdir}/libglapi.so.* \
        ${D}${libdir}/libgbm.so.* \
        ${D}${libdir}/libvulkan_broadcom.so ; do
        [ -f "$so" ] || continue
        ln -f "$so" "${D}${GPU_LAYER_LIBDIR}/$(basename $so)"
    done
}

FILES:${PN}-gpulayer += "${GPU_LAYER_LIBDIR}/*"

PRIVATE_LIBS:${PN}-gpulayer = "\
    libgbm.so.1 \
    libglapi.so.0 \
    libEGL.so.1 \
    libGLESv2.so.2 \
    libvulkan_broadcom.so \
    "
