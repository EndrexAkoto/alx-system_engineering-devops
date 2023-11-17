# Traffic increase in Nginx server

# Default file ULIMIT increase
exec { 'fix--for-nginx':
     # ULIMIT value modified
     command => '/bin/sed -i "s/15/4096/" /etc/default/nginx',
     #Sed command path specification
     path => '/usr/local/bin/:/bin/',
}

# Nginx restart
exec { 'nginx-restart':
     # Nginx restart service
     command => '/etc/init.d/nginx restart',
     # Init.d path specification
     path => '/etc/init.d/',
}
