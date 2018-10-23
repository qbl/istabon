$project = 'qblfrb-kubernetes-lab'

gauth_credential { 'gauth-credential':
  provider => serviceaccount,
  path     => '/home/iqbalfarabi/gcp-auth.json',
  scopes   => ['https://www.googleapis.com/auth/compute'],
}

gcompute_network { 'kubernetes-the-hard-way':
  ensure                  => present,
  auto_create_subnetworks => false,
  project                 => $project,
  credential              => 'gauth-credential',
}