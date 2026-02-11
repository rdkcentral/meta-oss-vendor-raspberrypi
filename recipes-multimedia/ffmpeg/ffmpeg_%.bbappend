EXTRA_OECONF:append = " \
    --enable-decoder=ac3 \
    --enable-decoder=eac3 \
    --disable-decoder=vp9 \
    --disable-decoder=h264 \
    "

EXTRA_OECONF:remove = "--disable-everything"
