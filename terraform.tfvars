#####################
# libvirt variables #
#####################
# A remote host running libvirt
# eg: an host with more than 8GB or RAM
libvirt_uri = "qemu:///system"

# A custom pool defined on the libvirt host
# eg: a pool backed by a fast SSD
pool = "default"

#####################
# Cluster variables #
#####################
master_count = 3
worker_count = 2

# instance user name
username = "sles"

# A range that doesn't conflict with the SUSE network
# and allows a similar naming.
#network = "172.30.0.0/22"
#net_mode = "route"

# Image url - can be local file downloaded in advance
img_source_url = "SLES15-SP1-JeOS.x86_64-15.1-OpenStack-Cloud-GMC3.qcow2"

# Additional packages that you may want to install in the initialization process.
packages = [
]

# Add your key here as you would do for the `~/.ssh/authorized_keys` file. They
# will be added into this same file for each node.
authorized_keys = [
"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCvbaSjWaahntI3QRFcNuHzvykn5J//eZEfwhB3uSCqroUyompB0gORKEkrOoEhl3tFkZUIvdoEv4Nx5vHYnntpHvzQR3zV01kB/0pIGnAyNE+DMy8qKtL++VzPF1CaPU0BJRZjR49h78Ed2C7MuMaKTnQGR4rsS9zxn8Lspld+L2ZWTacfQiAU878p23ADKMgfkETTiAR0EgEmaN0oHIjFJrCxvz6eZe9GoBHKNlj7PKm/+hxsuP+O4+xu97kB71zdFgKSV7GnI059ggH7rlpjaYgibvOXWoMAEosC9GPjRJMH54cDQaKagarSazrkfeS5x7VyHzZJS84GOmvs2Wf root@nodea"
]
caasp_registry_code = "INTERNAL-USE-ONLY-5f03b309b9b3a613"
#ntp_servers = ["0.novell.pool.ntp.org", "1.novell.pool.ntp.org", "2.novell.pool.ntp.org", "3.novell.pool.ntp.org"]
