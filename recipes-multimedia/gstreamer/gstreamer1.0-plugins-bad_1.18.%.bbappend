# Enabling hls as it is removed from OSS layer.
EXTRA_OEMESON:append = " -Dhls=enabled"

# Enable V4L codecs for hardware decoder support
PACKAGECONFIG:append = " v4l2codecs"
