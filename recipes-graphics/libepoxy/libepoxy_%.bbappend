# Below configurations are based on RPI4 platform configured with 'vc4graphics'.
EGLLIBNAME = "libEGL.so.1"
GLES1LIBNAME = "libGLESv1_CM.so"
GLES2LIBNAME = "libGLESv2.so.2"

TARGET_CFLAGS  += " \
    -DEGL_LIB_NAME=${EGLLIBNAME} \
    -DGLES1_LIB_NAME=${GLES1LIBNAME} \
    -DGLES2_LIB_NAME=${GLES2LIBNAME} \
    "
