#!/bin/bash

# Check for required environment variables
REQUIRED_VARS="MYORIGIN MYHOSTNAME RELAYHOST RELAYUSER RELAYPASSWORD ROOTALIAS"

for var in $REQUIRED_VARS; do
  if [ -z "${!var}" ]; then
    echo "Error: Environment variable $var is not set!"
    exit 1
  fi
done

cat /etc/postfix/main.cf.tmpl | envsubst > /etc/postfix/main.cf

echo "$RELAYHOST $RELAYUSER:$RELAYPASSWORD" > /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd

echo root: $ROOTALIAS >> /etc/postfix/aliases
newaliases

exec postfix start-fg