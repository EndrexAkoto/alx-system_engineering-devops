#!/usr/bin/env bash
# This script installs and configures an Nginx web server.

# Check if the script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root."
  exit 1
fi

# Install Nginx
apt update
apt install -y nginx

# Configure Nginx to listen on port 80
cat > /etc/nginx/sites-available/default <<EOF
server {
    listen 80;
    server_name _;
    location / {
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_pass http://127.0.0.1:5000;
    }
    location /redirect_me {
        return 301 http://\$host/;
    }
}
EOF

# Create a page that contains "Hello World!"
echo "Hello World!" > /var/www/html/index.html

# Restart Nginx without using systemctl
service nginx restart

echo "Nginx has been installed and configured."
