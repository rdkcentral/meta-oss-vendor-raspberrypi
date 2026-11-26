do_configure:append() {
    if [ -f "${WORKDIR}/zram-swap-init" ]; then
        sed -i 's/ZRAM_SIZE_PERCENT=100/ZRAM_SIZE_PERCENT=60/g' ${WORKDIR}/zram-swap-init
    fi
}

SYSTEMD_AUTO_ENABLE:${PN} = "enable"
