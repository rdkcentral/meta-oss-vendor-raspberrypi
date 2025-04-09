PACKAGECONFIG:append = " ${@bb.utils.filter('DISTRO_FEATURES', 'alsa x11', d)}"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://0013-yocto-drop-opus-raw-audio-data-according-to-clip-meta-data.patch"

