# ------------------------------------------------------------------------------
# Distcc
# ------------------------------------------------------------------------------

# distcc does not like NFS volumes
DISTCC_DIR=/tmp/${USER}/distcc
mkdir -p ${DISTCC_DIR}

# May be overwritten if avahi is around
ARCH=$(uname -i)

# should make this more generic using avahi
if [ "$(basename `which avahi-browse`)" = "avahi-browse" ]
then
	DISTCC_HOSTS=$(avahi-browse -rpt _distcc_arch._tcp | grep "arch=$ARCH" | cut -d ';' -f 4 | tr '\n' ' ')
fi

