#!/bin/sh
#
# Sets user env vars for builder image
UUID=$( id -u )
GUID=$( id -g )

cat >> .env <<EOF
USERID=${UUID}:${GUID}
USER_ID=${UUID}
GROUP_ID=${GUID}
EOF

