#Temporary until westeros.inc get updated to latest in common layer. Refer Comcast jira RDK-49476
LICENSE = "Apache-2.0"

PV = "1.0+gitr${SRCPV}"

SRC_URI = "${WESTEROS_URI}"
SRCREV = "${WESTEROS_SRCREV}"

WESTEROS_URI ?= "${CMF_GIT_ROOT}/components/opensource/westeros;protocol=${CMF_GIT_PROTOCOL};branch=${CMF_GIT_MASTER_BRANCH};name=westeros"
# Tip of westeros master as of Mar 7, 2024
WESTEROS_SRCREV = "04c096cb3df0bc0797f5b6bc568e1d11b62dcb5b"

LICENSE_LOCATION ?= "${S}/LICENSE"
LIC_FILES_CHKSUM = "file://${LICENSE_LOCATION};md5=8fb65319802b0c15fc9e0835350ffa02"

SRCREV_FORMAT = "westeros"
