# 2 additional patch from LGI
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://0041-qtdemux-senc-parser-parse-from-traf-box.patch"

# RDKVREFPLT-5867: dab-adapter needs wavenc to convert TTS output to PCM16LE format
EXTRA_OEMESON:remove = "-Dwavenc=disabled"
