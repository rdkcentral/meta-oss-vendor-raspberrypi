CXXFLAGS_append = "${@bb.utils.contains('DISTRO_FEATURES', 'enable_ermgr', ' -DUSE_ESSRMGR_UDS_IMPL', '', d)}"
