#!/bin/bash

#DHISURL="http://?????@is.dhis.org/"

if [ -n "$DHISURL" ]; then
    wget -4 -q -O - "$DHISURL?UpdateTimeout=0&IPAddr=$WAN4IP"
    wget -6 -q -O - "$DHISURL?UpdateTimeout=0&IPAddr=$LOCAL6IP"
fi
