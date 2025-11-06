#!/bin/bash

cd "$(dirname "$0")"
. functions

echo "Configuring OpenSIPS-CP database connection..."

sed -i "s/localhost/${MYSQL_IP}/g" /var/www/html/opensips-cp/config/db.inc.php

sed -i "s/127.0.0.1/${OPENSIPS_IP}/g" /var/www/html/opensips-cp/config/db_schema.mysql

exists=$(
  mysql -N -s \
    -h "$MYSQL_IP" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -D "$MYSQL_DATABASE" \
    -e "SELECT EXISTS(
           SELECT 1 FROM information_schema.tables
           WHERE table_schema='${MYSQL_DATABASE}'
             AND table_name='ocp_tools_config'
         );" || echo 0
)

if [[ "$exists" == "1" ]]; then
  echo "Schema present. Skipping import."
else
  echo "Schema missing (at least ocp_tools_config). Importing..."
  add_table "/var/www/html/opensips-cp/config/db_schema.mysql"
fi