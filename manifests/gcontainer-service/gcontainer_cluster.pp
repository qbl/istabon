gauth_credential { 'mycred':
  provider => serviceaccount,
  path     => '/home/iqbalfarabi/gcp-auth.json',
  scopes   => ['https://www.googleapis.com/auth/cloud-platform'],
}

gcontainer_cluster { 'istabon':
  ensure             => present,
  initial_node_count => 2,
  node_config        => {
    machine_type => 'n1-standard-4',
    disk_size_gb => 500,
  },
  zone               => 'asia-east1-a',
  project            => 'qblfrb-kubernetes-lab',
}
