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

gcompute_firewall { 'kubernetes-the-hard-way-allow-internal':
  ensure      => present,
  allowed     => [
    { ip_protocol => 'tcp' },
    { ip_protocol => 'udp' },
    { ip_protocol => 'icmp' },
  ],
  source_ranges => [
    '10.240.0.0/24',
    '10.200.0.0/16',
  ],
  network     => 'projects/qblfrb-kubernetes-lab/global/networks/kubernetes-the-hard-way',
  project     => $project,
  credential  => 'gauth-credential',
}

gcompute_firewall { 'kubernetes-the-hard-way-allow-external':
  ensure      => present,
  allowed     => [
    {
      ip_protocol => ['tcp'],
      ports       => ['22', '6443'],
    },
    {
      ip_protocol => ['icmp'],
    },
  ],
  source_ranges => ['0.0.0.0/0'],
  network     => 'projects/qblfrb-kubernetes-lab/global/networks/kubernetes-the-hard-way',
  project     => $project,
  credential  => 'gauth-credential',
}