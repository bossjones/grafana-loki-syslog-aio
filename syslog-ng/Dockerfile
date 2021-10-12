FROM balabit/syslog-ng:latest

# RUN apt-get update && apt-get install software-properties-common -y && \
#     apt install geoipupdate mmdb-bin syslog-ng-mod-geoip2 tar gzip autogen autoconf libtool libgeoip-dev wget -y && \
#     apt install libnet-cidr-lite-perl libtext-csv-xs-perl libgeoip2-perl -y
RUN apt-get update && apt-get install software-properties-common -y && \
    apt install mmdb-bin syslog-ng-mod-geoip2 tar gzip autogen autoconf libtool libgeoip-dev wget -y && \
    apt install libnet-cidr-lite-perl libtext-csv-xs-perl libgeoip2-perl -y

# SOURCE: https://dev.maxmind.com/geoip/geoip2/geolite2/
RUN set -x; mkdir -p /geoip && \
    cd /geoip && \
    wget https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz && \
    wget https://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz && \
    wget https://geolite.maxmind.com/download/geoip/database/GeoLite2-ASN.tar.gz && \
    gunzip GeoLite2-City.tar.gz && \
    gunzip GeoLite2-Country.tar.gz && \
    gunzip GeoLite2-ASN.tar.gz && \
    tar -xvf GeoLite2-City.tar && \
    tar -xvf GeoLite2-Country.tar && \
    tar -xvf GeoLite2-ASN.tar && \
    mv -v GeoLite2-*/*.mmdb . && \
    rm -rfv GeoLite2-{ASN,City,Country}_* && \
    rm -rfv *.tar && \
    rm -rfv *.tar.gz
