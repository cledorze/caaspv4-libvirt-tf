## Load balancer

Terraform will create a static DHCP configuration to be used.

The load balancer will be named `ag-lb.ag-test.net` and will always have the
`10.17.1.0` IP address.

## Topology

The cluster will be made by these machines:

  * Load balancer
  * X master nodes: have `kubeadm`, `kubelet` and `kubectl` preinstalled


## Deploy

Fill variable "name_prefix" with your ISV name 
Adjust node numbers in ./terraform.tfvars 
 master_count = 3
 worker_count = 2
terraform init
terraform apply
