package { 'curl':
  ensure => installed,
  name => curl
}

exec { 'download cfssl':
  command => '/usr/bin/curl -o cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64',
  require => Package['curl']
}

exec { 'chmod +x cfssl':
  command => '/bin/chmod +x cfssl',
  require => Exec['download cfssl']
}

exec { 'mv cfssl':
  command => '/bin/mv cfssl /usr/local/bin/cfssl',
  require => Exec['chmod +x cfssl']
}

exec { 'download cfssljson':
  command => '/usr/bin/curl -o cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64',
  require => Package['curl']
}

exec { 'chmod +x cfssljson':
  command => '/bin/chmod +x cfssljson',
  require => Exec['download cfssljson']
}

exec { 'mv cfssljson':
  command => '/bin/mv cfssljson /usr/local/bin/cfssljson',
  require => Exec['chmod +x cfssljson']
}