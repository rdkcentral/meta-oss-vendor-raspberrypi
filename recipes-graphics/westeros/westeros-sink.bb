include recipes-graphics/westeros/westeros.inc

SUMMARY = "This receipe compiles the westeros compositor gstreamer sink element"

LICENSE = "LGPLv2.1"

S = "${WORKDIR}/git/westeros-sink"

LICENSE_LOCATION = "${S}/../LICENSE"

inherit autotools pkgconfig

DEPENDS = "wayland westeros essos virtual/westeros-soc"

#For sky
CFLAGS += "${@bb.utils.contains('DISTRO_FEATURES', 'window_mode_1080p', " -DMODE_1080P", "", d)}"
DEPENDS:append = "${@bb.utils.contains('DISTRO_FEATURES', 'westeros_sink_software_decode', ' libav', '', d)}"
CFLAGS:append = "${@bb.utils.contains('DISTRO_FEATURES', 'westeros_sink_software_decode', ' -DENABLE_SW_DECODE', '', d)}"
LDFLAGS:append = "${@bb.utils.contains('DISTRO_FEATURES', 'westeros_sink_software_decode', ' -lavcodec -lavutil', '', d)}"
SRC_URI += "file://0001-westeros-sink-1080p.patch;patchdir=."
SRC_URI += "file://0001-RDKEVL-6765-temp-fix-compile-err-with-westeros-1-1-61.patch;patchdir=."

DEPENDS += "${@bb.utils.contains('DISTRO_FEATURES', 'gstreamer1', 'gstreamer1.0-plugins-base', '', d)}"
SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'westeros_sink_software_decode', ' file://essrmgr.conf ',' ',d)}"

export  SWDECODER_ENABLED = "${@bb.utils.contains('DISTRO_FEATURES','westeros_sink_software_decode','y','n',d)}"

do_install:append () {
    if [ "${SWDECODER_ENABLED}" = "y" ]; then
        install -d ${D}${sysconfdir}/default
        install -m 0644 ${WORKDIR}/essrmgr.conf ${D}${sysconfdir}/default
    fi
}

FILES:${PN}:append = " ${sysconfdir}/default/essrmgr.conf"


