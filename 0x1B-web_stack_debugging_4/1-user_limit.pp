# Allow holberton to log in and increase file access

# Increase file limit for holberton
exec { 'increase-hard-file-limit-for-holberton-user':
  command => "sed -i '/^holberton hard/s/4/50000/' /etc/security/limits.conf",
  path    => '/usr/local/bin/:/bin/',
}

# Holberton user soft file limit increase
exec { 'increase-soft-file-limit-for-holberton-user':
  command => 'sed -i "/^holberton soft/s/5/50000/" /etc/security/limits.conf',
  path    => '/usr/local/bin/:/bin/',
}

