# bbappend for raspberryPi
#

PACKAGECONFIG = "incapp inctest increndergl incsbprotocol xdgv4"
PACKAGECONFIG:append = " ${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', 'modules', '', d)}"

# enable Linux DMA buffer for RPi4
PACKAGECONFIG:append_raspberrypi4 = " incldbprotocol"

CXXFLAGS:append = " ${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', '-DWESTEROS_PLATFORM_DRM', '-DWESTEROS_PLATFORM_RPI -DWESTEROS_INVERTED_Y -DBUILD_WAYLAND -I${STAGING_INCDIR}/interface/vmcs_host/linux', d)} "
CXXFLAGS:append = " ${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', '-DUSE_MESA', '', d)}"

inherit systemd update-rc.d

CXXFLAGS:append = "${@bb.utils.contains('DISTRO_FEATURES', 'enable_ermgr', ' -DUSE_ESSRMGR_UDS_IMPL', '', d)}"

do_configure:prepend () {
    sed -i -e 's/-lwesteros_simplebuffer:client/-lwesteros_compositor -lwesteros_simplebuffer:client/g' ${S}/rpi/westeros-sink/Makefile.am
}

do_compile:prepend () {
    export WESTEROS_COMPOSITOR_EXTRA_LIBS="${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', '-lEGL -lGLESv2', '-lEGL -lGLESv2 -lbcm_host', d)}"
}

do_install:append () {

    # install systemd services for auto start
    if [ "${@bb.utils.contains("DISTRO_FEATURES", "systemd", "yes", "no", d)}" = "yes" ]; then
        install -D -m 0644 ${S}/systemd/westeros.service ${D}${systemd_unitdir}/system/westeros.service
    else
        install -D -m 0755 ${S}/systemd/westeros.sysvinit ${D}${sysconfdir}/init.d/westeros
    fi
    install -D -m 0755 ${S}/systemd/westeros-init ${D}${bindir}/westeros-init

    # Appending required environment variable for westeros
    install -D -m 0644 ${S}/systemd/westeros-env ${D}${sysconfdir}/default/westeros-env

    # defining environment variable for westeros
    echo "XDG_RUNTIME_DIR=/run" >> ${D}${sysconfdir}/default/westeros-env
    echo "WAYLAND_DISPLAY=wayland-0" >> ${D}${sysconfdir}/default/westeros-env

    if [ "${@bb.utils.contains("DISTRO_FEATURES", "systemd", "yes", "no", d)}" = "yes" ]; then
        sed -i '/Compositor/ a After=lircd.service lircd.socket' ${D}${systemd_unitdir}/system/westeros.service
    fi
    sed -i '/^exec/i MODULE=/usr/lib/libresolutionmodule.so.0.0.0' ${D}${bindir}/westeros-init
    sed -i 's/$RENDERER/$RENDERER --module $MODULE/g' ${D}${bindir}/westeros-init
    # westeros service is not required when RDK Shell is enabled
    if [ "${@bb.utils.contains('DISTRO_FEATURES', 'rdkshell', 'yes', 'no', d)}" = "yes" ]; then
        rm -rf ${D}${systemd_unitdir}
    fi
}

do_install:append_rasberrypi4 () {
    sed -i '/exec/i export WESTEROS_DRM_CARD=/dev/dri/card1' ${D}${bindir}/westeros-init
}

LDFLAGS:append = " ${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', '', '-lvchostif', d)}"

INITSCRIPT_NAME = "westeros"
INITSCRIPT_PARAMS = "defaults"

SYSTEMD_SERVICE:${PN} = "${@bb.utils.contains('DISTRO_FEATURES', 'rdkshell', '', 'westeros.service', d)}"
