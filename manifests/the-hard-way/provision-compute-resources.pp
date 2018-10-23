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

gcompute_region { 'asia-east1':
  name       => 'asia-east1',
  project    => $project,
  credential => 'gauth-credential',
}

gcompute_subnetwork { 'kubernetes':
  ensure        => present,
  ip_cidr_range => '10.240.0.0/24',
  network       => 'kubernetes-the-hard-way',
  region        => 'asia-east1',
  project       => $project,
  credential    => 'gauth-credential',
}