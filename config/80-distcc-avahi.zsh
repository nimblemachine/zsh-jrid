# ------------------------------------------------------------------------------
# Distcc
# ------------------------------------------------------------------------------


#
# TODO very preliminary ... there is more work to do there

# distcc does not like NFS volumes
DISTCC_DIR=/tmp/${USER}/distcc
mkdir -p ${DISTCC_DIR}


# May be overwritten if avahi is around

DISTCC_HOSTS="newton faraday galileo"
DISTCC_64="kangaroo"

# should make this more generic using avahi
if [ "$(basename `which avahi-browse`)" = "avahi-browse" ]; then
DISTCC_HOSTS="$(avahi-browse -p -t _distcc._tcp | cut -d ';' -f 4 | sed -e "s/.*64\(.*\)/\1 /" | tr -d '\n')"
DISTCC_HOSTS=$(echo $DISTCC_HOSTS | sed -e "s/\(.*\)${DISTCC_64}\(.*\)/\1\2/")
fi

case $(uname -m) in
	x86_64)
		DISTCC_HOSTS=${DISTCC_64}
		;;
esac



