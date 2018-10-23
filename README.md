# Istabon

An experiment to provision Kubernetes cluster a la Kubernetes The Hard Way using Puppet

# The Easy Way

## 0. Creating Puppet Server

1. Create a compute instance

    ```
    gcloud compute instances create puppet-server --zone asia-east1-a --machine-type n1-standard-1 --image ubuntu-1604-xenial-v20181004 --image-project ubuntu-os-cloud
    ```

2. Ssh

    ```
    gcloud compute ssh puppet-server
    ```

## 1. Installing Necessary Tools on Puppet Server

1. Install `puppet-common`

    ```
    sudo apt-get install puppet-common
    ```

2. Copy service account credentials, for example `gcp-auth.json`

3. Install `google-auth` and `google-api-client`

    Create a file named `gauth.pp`, fill it with:

    ```
    package { [
        'googleauth',
        'google-api-client',
      ]:
        ensure   => present,
        provider => gem,
    }
    ```

    Then apply:

    ```
    puppet apply gauth.pp
    ```

3. Activate service account

    ```
    gcloud auth activate-service-account puppet-master@qblfrb-kubernetes-lab.iam.gserviceaccount.com --key-file=gcp-auth.json --project=qblfrb-kubernetes-lab
    ```

## 2. Provisioning Cluster

1. Create a file named `gcontainer_cluster.pp`, fill it with:

    ```
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
      credential         => 'mycred',
    }
    ```

2. Apply

    ```
    puppet apply gcontainer_cluster.pp
    ```

## 3. Validating Cluster

1. Get cluster credentials

    ```
    gcloud container clusters get-credentials istabon
    ```

2. Validate nodes and kube-system pods exist

    ```
    kubectl get nodes
    kubectl get pods -n kube-system
    ```


