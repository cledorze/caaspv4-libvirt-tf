# Deploy a CaaSPv4 Cluster 

```
git clone https://github.com/cledorze/caaspv4-libvirt-tf
mkdir ./your-isv-name
cd ./your-isv-name
cp -ax ../caaspv4-libvirt-tf/* ./
````

## Base image
1) DL the base image either from IBS or existing ISV repo : 
http://download.suse.de/install/SLE-15-SP1-JeOS-GM/SLES15-SP1-JeOS.x86_64-15.1-OpenStack-Cloud-GM.qcow2

2) Place this image in the root of this repo. (SLES15-SP1-JeOS.x86_64-15.1-OpenStack-Cloud-GMC3.qcow2)

## Init and Apply
3) Inside the root of the directory do a : terraform init (verify that you have terraform-libvirt provider installed)
4) Edit variables.tf and modify at least : 

variable "name_prefix" {
  type        = "string"
  default     = "ISVname"
  description = "Optional prefix to be able to have multiple clusters on one host"
}

variable "network" {
  type        = "string"
  default     = "10.X0.0.0/22"
  description = "Network used by the cluster"
  
5) Edit terraform.tfvars and adapt the number of workers/masters if needed.
6) ```
   terraform init
   terraform apply
   ``` 

Wait for "Apply complete!" 

## Load balancer (workaround regarding LB IP resolution fail)
7) add the LB IP/hostame manually to each k8s node + hypervisor
regarding ISV name (example with jenkinsx) : 
10.130.1.0      jenkinsxlb-0.jenkinsxsuse-sap.net jenkinsxlb-0
10.130.2.0      jenkinsxmaster-0.jenkinsxsuse-sap.net jenkinsxmaster-0
10.130.2.1      jenkinsxmaster-1.jenkinsxsuse-sap.net jenkinsxmaster-1
10.130.2.2      jenkinsxmaster-2.jenkinsxsuse-sap.net jenkinsxmaster-2
10.130.3.0      jenkinsxworker-0.jenkinsxsuse-sap.net jenkinsxworker-0
10.130.3.1      jenkinsxworker-1.jenkinsxsuse-sap.net jenkinsxworker-1

## Init, bootstrap and add nodes to your k8s cluster
8) skuba cluster init --control-plane FQDN-LB0 ISVname (eg : skuba cluster init --control-plane artifactorylb-0.artifactoryisv-lab.net artifactory)

9) cd ISVname

10) eval \`ssh-agent -s\`

11) ssh-add

12) skuba node bootstrap --user sles --sudo --target 10.50.2.0 artifactorymaster-0.artifactoryisv-lab.net -v 4

13) You could start geting cluster infos : 
        - export KUBECONFIG=/CaaSP4/ISV/JFrog/Artifactory/caaspv4-libvirt-tf/artifactory/admin.conf
        - watch kubectl get nodes 
        
14) Add all nodes :
skuba node join --role master --user sles --sudo --target 10.X0.2.1 isvmaster-1.isv-lab.net -v 4

skuba node join --role master --user sles --sudo --target 10.X0.2.2 isvmaster-2.isv-lab.net -v 4

skuba node join --role worker --user sles --sudo --target 10.X0.3.0 isvworker-0.isv-lab.net -v 4

skuba node join --role worker --user sles --sudo --target 10.X0.3.1 isvworker-1.isv-lab.net -v 4

## LAB : Setup Helm/tiller + NFS SC
15) On the host ISV's directory :

wget https://get.helm.sh/helm-v2.14.1-linux-amd64.tar.gz

tar -xvzf ./helm-v2.14.1-linux-amd64.tar.gz

cd linux-amd64/

export PATH=$PATH:/root/CaaSP4/helm/linux-amd64/

16) kubectl apply -f ./ISV/tiller-rbac.yaml

17) helm init --service-account tiller

## NFS : Access the Lab storage Class
18) On workers, install nfs-client "zypper in nfs-client"
19) Deploy and change the default storage Class :

helm install stable/nfs-client-provisioner --set nfs.server=10.10.10.11 --set nfs.path=/srv/nfs1

kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
