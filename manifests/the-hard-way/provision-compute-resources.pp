$project = 'qblfrb-kubernetes-lab'

gauth_credential { 'gauth-credential':
  provider => serviceaccount,
  path     => '/home/iqbalfarabi/gcp-auth.json',
  scopes   => ['https://www.googleapis.com/auth/compute'],
}

gcompute_region { 'asia-east1':
  name       => 'asia-east1',
  project    => $project,
  credential => 'gauth-credential',
}

gcompute_zone { 'asia-east1-a':
  project    => $project,
  credential => 'gauth-credential',
}

gcompute_machine_type { 'n1-standard-1':
  zone       => 'asia-east1-a',
  project    => $project,
  credential => 'gauth-credential',
}

gcompute_network { 'kubernetes-the-hard-way':
  ensure                  => present,
  auto_create_subnetworks => false,
  project                 => $project,
  credential              => 'gauth-credential',
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

gcompute_address { 'kubernetes-the-hard-way':
  ensure     => present,
  region     => 'asia-east1',
  project    => $project,
  credential => 'gauth-credential',
}

gcompute_instance { 'controller-0':
  ensure             => present,
  can_ip_forward     => true,
  machine_type       => 'n1-standard-1',
  disks              => [
    {
      auto_delete    => true,
      boot           => true,
      initialize_params   => {
        disk_size_gb      => 200,
        source_image      => 'https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20181003',
      },
    },
  ],
  network_interfaces => [
    {
      network_ip     => '10.240.0.10',
      subnetwork     => 'kubernetes',
    },
  ],
  tags               => {
    items => ['kubernetes-the-hard-way', 'controller']
  },
  zone               => 'asia-east1-a',
  project            => $project,
  credential         => 'gauth-credential',
}

gcompute_instance { 'controller-1':
  ensure             => present,
  can_ip_forward     => true,
  machine_type       => 'n1-standard-1',
  disks              => [
    {
      auto_delete    => true,
      boot           => true,
      initialize_params   => {
        disk_size_gb      => 200,
        source_image      => 'https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20181003',
      },
    },
  ],
  network_interfaces => [
    {
      network_ip     => '10.240.0.11',
      subnetwork     => 'kubernetes',
    },
  ],
  tags               => {
    items => ['kubernetes-the-hard-way', 'controller']
  },
  zone               => 'asia-east1-a',
  project            => $project,
  credential         => 'gauth-credential',
}

gcompute_instance { 'controller-2':
  ensure             => present,
  can_ip_forward     => true,
  machine_type       => 'n1-standard-1',
  disks              => [
    {
      auto_delete    => true,
      boot           => true,
      initialize_params   => {
        disk_size_gb      => 200,
        source_image      => 'https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20181003',
      },
    },
  ],
  network_interfaces => [
    {
      network_ip     => '10.240.0.12',
      subnetwork     => 'kubernetes',
    },
  ],
  tags               => {
    items => ['kubernetes-the-hard-way', 'controller']
  },
  zone               => 'asia-east1-a',
  project            => $project,
  credential         => 'gauth-credential',
}

gcompute_instance { 'worker-0':
  ensure             => present,
  can_ip_forward     => true,
  machine_type       => 'n1-standard-1',
  metadata           => {
    'pod-cidr' => '10.200.0.0/24'
  },
  disks              => [
    {
      auto_delete    => true,
      boot           => true,
      initialize_params   => {
        disk_size_gb      => 200,
        source_image      => 'https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20181003',
      },
    },
  ],
  network_interfaces => [
    {
      network_ip     => '10.240.0.20',
      subnetwork     => 'kubernetes',
    },
  ],
  tags               => {
    items => ['kubernetes-the-hard-way', 'worker']
  },
  zone               => 'asia-east1-a',
  project            => $project,
  credential         => 'gauth-credential',
}

gcompute_instance { 'worker-1':
  ensure             => present,
  can_ip_forward     => true,
  machine_type       => 'n1-standard-1',
  metadata           => {
    'pod-cidr' => '10.200.1.0/24'
  },
  disks              => [
    {
      auto_delete    => true,
      boot           => true,
      initialize_params   => {
        disk_size_gb      => 200,
        source_image      => 'https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20181003',
      },
    },
  ],
  network_interfaces => [
    {
      network_ip     => '10.240.0.21',
      subnetwork     => 'kubernetes',
    },
  ],
  tags               => {
    items => ['kubernetes-the-hard-way', 'worker']
  },
  zone               => 'asia-east1-a',
  project            => $project,
  credential         => 'gauth-credential',
}

gcompute_instance { 'worker-2':
  ensure             => present,
  can_ip_forward     => true,
  machine_type       => 'n1-standard-1',
  metadata           => {
    'pod-cidr' => '10.200.2.0/24'
  },
  disks              => [
    {
      auto_delete    => true,
      boot           => true,
      initialize_params   => {
        disk_size_gb      => 200,
        source_image      => 'https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20181003',
      },
    },
  ],
  network_interfaces => [
    {
      network_ip     => '10.240.0.22',
      subnetwork     => 'kubernetes',
    },
  ],
  tags               => {
    items => ['kubernetes-the-hard-way', 'worker']
  },
  zone               => 'asia-east1-a',
  project            => $project,
  credential         => 'gauth-credential',
}