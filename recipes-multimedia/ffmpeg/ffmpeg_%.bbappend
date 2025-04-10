EXTRA_OECONF:append = " \
    --enable-decoder=ac3 \
    --enable-decoder=eac3 \
"
EXTRA_OECONF:remove = "--disable-everything"
EXTRA_OECONF:append = " \
    --disable-decoder=vp9 \
"
