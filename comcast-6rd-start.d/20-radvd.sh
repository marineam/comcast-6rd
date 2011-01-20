#!/bin/bash

RADVDCONF="/etc/radvd.conf"
LOCAL6DNS="$LOCAL6IP"

write_conf() {
    cat >$RADVDCONF <<EOF
# Generated by radvd.sh
interface $LANIF {
    AdvSendAdvert on;
    AdvLinkMTU $SIXRDTUNMTU;

    AdvDefaultLifetime 3600;
    MaxRtrAdvInterval 60;
    MinRtrAdvInterval 10;

    prefix $LOCAL6PREFIX::/$LOCAL6PREFIXLEN {
        AdvOnLink on;
        AdvAutonomous on;

        AdvValidLifetime 86400;
        AdvPreferredLifetime 3600;
    };

    RDNSS $LOCAL6DNS {
        AdvRDNSSLifetime 120;
    };
};
EOF
}

radvd_reload() {
    /etc/init.d/radvd reload || /etc/init.d/radvd start
}

write_conf && radvd_reload
