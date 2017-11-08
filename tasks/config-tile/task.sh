#!/bin/bash

set -eu
om-linux \
  --target https://$OPSMAN_DOMAIN_OR_IP_ADDRESS \
  --username $OPS_MGR_USR \
  --password $OPS_MGR_PWD \
  --skip-ssl-validation \
  configure-product \
  --product-name p-mysql \
  --product-properties "$(cat templates/mysql-1.9.10-stripped.json)" \
  --product-network "$(cat templates/mysql-1.9.10-network.json)" \
  --product-resources "$(cat templates/mysql-1.9.10-resources.json)"
