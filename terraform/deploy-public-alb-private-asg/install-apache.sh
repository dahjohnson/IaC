#!/bin/bash

# Install Apache on Ubuntu

apt update
apt install apache2


cat > /var/www/gci/index.html << EOF
<html>
<head>
  <title> Apache on Ubuntu </title>
</head>
<body>
  <p> Apache was installed using Terraform!
</body>
</html>
EOF