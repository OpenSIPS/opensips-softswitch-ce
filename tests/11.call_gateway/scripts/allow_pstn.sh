mysql opensips -e "UPDATE subscriber SET acls = CONCAT(acls, 'P') WHERE username = '$1' AND domain = '$2';"