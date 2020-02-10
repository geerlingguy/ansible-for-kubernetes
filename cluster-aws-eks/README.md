# AWS EKS Kubernetes Cluster Example

This example demonstrates the setup of a highly-available AWS EKS Kubernetes cluster using Ansible to manage multiple CloudFormation templates.

## Usage

Prerequisites:

  - You must have an AWS account to run this example.
  - You must use an IAM account with privileges to create VPCs, Internet Gateways, EKS Clusters, Security Groups, etc.
  - This IAM account will inherit the `system:master` permissions in the cluster, and only that account will be able to make the initial changes to the cluster via `kubectl` or Ansible.

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

### Deploy an application to EKS with Ansible

There is a `deploy.yml` playbook which deploys a WordPress website (using MySQL for a database and EBS PVs for persistent storage) into the Kubernetes cluster.

Run the playbook to deploy the website:

    $ ansible-playbook -i inventory deploy.yml

#### Manage DNS for WordPress with Route53 and Ansible

If you set the following variables inside `vars/main.yml`, the Ansible playbook will also create a DNS A record pointing to the WordPress Load Balancer for you:

    wordpress_route53_zone: example.com
    wordpress_route53_domain: wordpress.example.com

Using this feature presumes you already have the hosted zone (e.g. `example.com`) configured in Route53.

> Note: If you don't have a zone configured in Route 53, you can leave these settings blank, and access the load balancer URL via DNS directly. You can find the load balancer's direct URL in the AWS Management Console, in the ELB's details in EC2 > Load Balancers.

### Install WordPress

After you run the playbook, you can visit your website URL (e.g. `http://wordpress.example.com/`) in a browser, and you should see the WordPress installer. Follow the installation instructions, and you'll end up with a new WordPress site.

### Delete the cluster and associated resources

After you're finished testing the cluster, run the `delete.yml` playbook:

    $ ansible-playbook -i inventory delete.yml

> Note: It's important to delete test clusters you're not actively using; each cluster is billed at the [EKS cluster hourly rate](https://aws.amazon.com/eks/pricing/) and can lead to unexpected charges at the end of the month!
