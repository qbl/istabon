package { ['googleauth', 'google-api-client',]:
  ensure   => present,
  provider => gem,
}
