package { 'rubygems':
  ensure => present,
}

package { ['googleauth', 'google-api-client',]:
  ensure   => present,
  provider => gem,
}