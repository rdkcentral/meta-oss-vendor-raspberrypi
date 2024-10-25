PACKAGECONFIG:append = " ${@bb.utils.filter('DISTRO_FEATURES', 'alsa x11', d)}"
