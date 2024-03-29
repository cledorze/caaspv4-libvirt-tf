#####################
# libvirt variables #
#####################

variable "libvirt_uri" {
  default     = "qemu:///system"
  description = "libvirt connection url - default to localhost"
}

variable "pool" {
  default     = "default"
  description = "pool to be used to store all the volumes"
}

#####################
# Cluster variables #
#####################

## fixme: see issue https://github.com/SUSE/avant-garde/issues/91
variable "img_source_url" {
#  type    = string
  default = "SLES15-SP1-JeOS.x86_64-15.1-OpenStack-Cloud-GMC3.qcow2"
}

variable "repositories" {
#  type = string
  default = "https://download.opensuse.org/repositories/devel:/CaaSP:/Head:/ControllerNode/openSUSE_Leap_15.0"
#  default = [
#    {
#      caasp_devel_leap15 = "https://download.opensuse.org/repositories/devel:/CaaSP:/Head:/ControllerNode/openSUSE_Leap_15.0"
#    },
#  ]

  description = "Urls of the repositories to mount via cloud-init"
}

variable "caasp_registry_code" {
  default     = "INTERNAL-USE-ONLY-e62a127779ce75cc"
  description = "TBD"
}

variable "sle_registry_code" {
  default     = "INTERNAL-USE-ONLY-5f03b309b9b3a613"
  description = "TBD"
}

variable "lb_memory" {
  default     = 2048
  description = "The amount of RAM for a load balancer node"
}

variable "lb_vcpu" {
  default     = 1
  description = "The amount of virtual CPUs for a load balancer node"
}

variable "master_count" {
  default     = 1
  description = "Number of masters to be created"
}

variable "master_memory" {
  default     = 8192
  description = "The amount of RAM for a master"
}

variable "master_vcpu" {
  default     = 2
  description = "The amount of virtual CPUs for a master"
}

variable "worker_count" {
  default     = 2
  description = "Number of workers to be created"
}

variable "worker_memory" {
  default     = 16384
  description = "The amount of RAM for a worker"
}

variable "worker_vcpu" {
  default     = 2
  description = "The amount of virtual CPUs for a worker"
}

variable "name_prefix" {
#  type        = string
  default     = "sapdh27"
  description = "Optional prefix to be able to have multiple clusters on one host"
}

variable "domain_name" {
#  type        = string
  default     = "suse-sap.net"
  description = "The domain name"
}

variable "net_mode" {
#  type        = string
  default     = "nat"
  description = "Network mode used by the cluster"
}

variable "network" {
#  type        = string
  default     = "10.110.0.0/22"
  description = "Network used by the cluster"
}

variable "authorized_keys" {
#  type        = list(string)
  default     = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCvbaSjWaahntI3QRFcNuHzvykn5J//eZEfwhB3uSCqroUyompB0gORKEkrOoEhl3tFkZUIvdoEv4Nx5vHYnntpHvzQR3zV01kB/0pIGnAyNE+DMy8qKtL++VzPF1CaPU0BJRZjR49h78Ed2C7MuMaKTnQGR4rsS9zxn8Lspld+L2ZWTacfQiAU878p23ADKMgfkETTiAR0EgEmaN0oHIjFJrCxvz6eZe9GoBHKNlj7PKm/+hxsuP+O4+xu97kB71zdFgKSV7GnI059ggH7rlpjaYgibvOXWoMAEosC9GPjRJMH54cDQaKagarSazrkfeS5x7VyHzZJS84GOmvs2Wf root@nodea"]
  description = "ssh keys to inject into all the nodes"
}

variable "packages" {
#  type = list(string)

  default = [
    "kubernetes-kubeadm",
    "kubernetes-kubelet",
    "kubernetes-client",
    "cri-o",
    "cni-plugins",
    "podman",
    "-docker",
    "-containerd",
    "-docker-runc",
    "-docker-libnetwork",
  ]

  description = "list of additional packages to install"
}

variable "username" {
  default     = "sles"
  description = "Username for the cluster nodes"
}

variable "password" {
  default     = "linux"
  description = "Password for the cluster nodes"
}

# Extend disk size to 24G (JeOS-KVM default size) because we use
# JeOS-OpenStack instead of JeOS-KVM image with libvirt provider
variable "disk_size" {
  default     = "25769803776"
  description = "disk size (in bytes)"
}
