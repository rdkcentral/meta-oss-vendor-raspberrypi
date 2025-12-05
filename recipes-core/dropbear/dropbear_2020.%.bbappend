do_install:append() {
    sed -i '/^StandardInput=socket/a\StandardOutput=null\nStandardError=null' ${D}${systemd_unitdir}/system/dropbear@.service
}

