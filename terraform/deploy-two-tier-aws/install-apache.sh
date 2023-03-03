#!/bin/bash

# Install Apache on Ubuntu

sudo apt update -y
sudo apt install -y apache2


sudo cat > /var/www/html/index.html << EOF
<html>
<head>
  <title> Apache on Ubuntu </title>
</head>
<body>
  <p> Apache was installed using Terraform!
</body>
</html>
EOF