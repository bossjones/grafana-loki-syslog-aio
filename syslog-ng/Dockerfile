FROM balabit/syslog-ng:latest

# https://github.com/jbonachera/docker-loki/blob/3749487d2a3b5b65bd2c49a0f4904589fad34b7c/Dockerfile
ARG GEOIP_ACCOUNTID
ARG GEOIP_LICENSE

RUN apt-get update && apt-get install software-properties-common -y && \
    apt install mmdb-bin syslog-ng-mod-geoip2 tar gzip autogen autoconf libtool libgeoip-dev wget -y && \
    apt install libnet-cidr-lite-perl libtext-csv-xs-perl libgeoip2-perl geoip-database geoip-bin geoip-database-extra python3-pip python3-jinja2 -y

# SOURCE: https://www.maxmind.com/en/accounts/621041/license-key/create
RUN set -x; mkdir -p /geoip && \
    cd /geoip && \
    wget https://github.com/maxmind/geoipupdate/releases/download/v4.8.0/geoipupdate_4.8.0_linux_amd64.deb && \
    dpkg -i geoipupdate_4.8.0_linux_amd64.deb && \
    echo "AccountID ${GEOIP_ACCOUNTID}\nLicenseKey ${GEOIP_LICENSE}\nEditionIDs GeoLite2-ASN GeoLite2-City GeoLite2-Country" > /etc/GeoIP.conf && \
    geoipupdate

# The following "path" variables can differ from the container defaults specified in the entrypoint.sh script.
# These are *optional* for most BYOE installations, which do noot differ from the install location used.
# in the container version of SC4S.  Failure to properly set these will cause startup failure.
ENV SC4S_ETC=/etc/syslog-ng
ENV SC4S_VAR=/var/lib/syslog-ng
ENV SC4S_BIN=/usr/bin
ENV SC4S_SBIN=/usr/sbin
ENV SC4S_TLS=/etc/syslog-ng/tls

COPY package/etc/conf.d /etc/syslog-ng/conf.d
COPY package/etc/context_templates /etc/syslog-ng/context_templates


# # SOURCE: https://dev.maxmind.com/geoip/geoip2/geolite2/

# https://github.com/splunk/splunk-connect-for-syslog/blob/main/package/Dockerfile
# RUN curl -fsSL https://goss.rocks/install | GOSS_VER=v0.3.16 sh
# COPY package/etc/goss.yaml /etc/syslog-ng/goss.yaml
