# Istabon

An experiment to provision Kubernetes cluster a la Kubernetes The Hard
Way using Puppet

# Steps

## Setting up Puppet Server

1. Create a Vagrant VM to act as Puppet Server

    ```
    vagrant up puppetserver
    ```

2. Ssh into the server

    ```
    vagrant ssh puppetserver
    ```

3. Install necessary tools

    ```
    sudo yum install rsync git vim nano emacs-nox
    sudo yum install -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
    sudo yum install -y puppetserver
    ```
