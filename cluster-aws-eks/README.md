# AWS EKS Kubernetes Cluster Example

This example demonstrates the setup of a highly-available AWS EKS Kubernetes cluster using Ansible to manage multiple CloudFormation templates.

## Usage

Prerequisites:

  - You must have an AWS account to run this example.
  - You must use an IAM account with privileges to create VPCs, Internet Gateways, EKS Clusters, Security Groups, etc.
  - This IAM account will inherit the `system:master` permissions in the cluster, and only that account will be able to make the initial changes to the cluster via `kubectl` or Ansible.
  - In your AWS account, you must have an EC2 Key Pair named `eks-example` (or change the name of the `aws_key_name` in `vars/main.yml` to a Key Pair you'd like to use).

### Build the Cluster via CloudFormation Templates with Ansible

Make sure you have the `boto` Python library installed (e.g. via Pip with `pip3 install boto`), and then run the playbook to build the EKS cluster and nodegroup:

    $ ansible-playbook -i inventory main.yml

> Note: EKS Cluster creation is a slow operation, and could take 10-20 minutes.

After the cluster and nodegroup are created, you should see one EKS cluster and three EC2 instances running, and you can start to manage the cluster with Ansible.

### Set up authentication to the cluster via `kubeconfig`

  1. Install the `aws-iam-authenticator` following [these directions](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html).
  2. Create a `kubeconfig` file for EKS following [these directions](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html):

     ```
     $ aws eks --region us-east-1 update-kubeconfig --name eks-example --kubeconfig ~/.kube/eks-example
     ```

     This creates a `kubeconfig` file located in `~/kube/eks-example`.
  3. Tell `kubectl` where to find the `kubeconfig`:

     ```
     $ export KUBECONFIG=~/.kube/eks-example
     ```
  4. Test that `kubectl` can see the cluster:

     ```
     $ kubectl get svc
     NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
     kubernetes   ClusterIP   10.100.0.1   <none>        443/TCP   19m
     ```

## Managing the EKS Cluster with Ansible

TODO.

## Delete the cluster and resources

After you're finished testing the cluster, run the `delete.yml` playbook:

    $ ansible-playbook -i inventory delete.yml
