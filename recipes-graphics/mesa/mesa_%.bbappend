# RDKE-96: virtual/egl and related mesa provided packages are failing to link in inter layer build.
# RCA: mesa recipe does not include them in mesa-dev package but all the below mentioned packages are
# mapped against mesa.
# PREFERRED_PROVIDER_virtual/egl, PREFERRED_PROVIDER_virtual/libgl, PREFERRED_PROVIDER_virtual/libgles2 and
# PREFERRED_PROVIDER_virtual/libgbm
# Ref: https://github.com/rdkcentral/meta-product-raspberrypi/pull/21

RDEPENDS_${PN}-dev += " \
    libegl-mesa-dev \
    libgl-mesa-dev \
    libglapi-dev \
    libgbm-dev \
    libgles1-mesa-dev \
    libgles2-mesa-dev \
    libgles3-mesa-dev \
    "
