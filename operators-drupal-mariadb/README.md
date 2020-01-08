# Operators working in tandem - Drupal and MariaDB

This example demonstrates the use of two separate Kubernetes operators working in tandem to power a Drupal website. The [Drupal Operator](https://github.com/geerlingguy/drupal-operator) can work standalone, but only supplies a single MySQL database Pod, which is not great for high availability (HA) or maximizing database performance.

Instead, we tell the Drupal Operator to skip running its own database, and instead, point to a separate MariaDB cluster, managed by the [MariaDB Operator](https://github.com/geerlingguy/mariadb-operator).

## Usage

  1. Start a new Minikube cluster: `minikube start --memory 4g`
  2. Install the [MariaDB Operator](https://github.com/geerlingguy/mariadb-operator):

     ```
     kubectl apply -f https://raw.githubusercontent.com/geerlingguy/mariadb-operator/master/deploy/mariadb-operator.yaml
     ```

  3. Install the [Drupal Operator](https://github.com/geerlingguy/drupal-operator):

     ```
     kubectl apply -f https://raw.githubusercontent.com/geerlingguy/drupal-operator/master/deploy/drupal-operator.yaml
     ```

  4. Create `mysite` namespace:

     ```
     kubectl create namespace mysite
     ```

  5. Deploy MariaDB instance into `mysite`:

     ```
     kubectl apply -f drupal/mariadb.yml
     ```

  6. Deploy Drupal instance into `mysite`, using MariaDB database URL and not the internal MySQL Pod.

     ```
     kubectl apply -f drupal/drupal.yml
     ```

  7. Wait for the pods to get to the `Running` state:

     ```
     watch kubectl get pods -n mysite
     ```

  8. Get the IP address for Minikube using `minikube ip`, then add a line like the following to your `/etc/hosts` file:

     ```
     MINIKUBE_IP_HERE  mysite.test
     ```

Once the pods are running, visit `http://mysite.test/` in your browser, and you should see be able to install Drupal using its installation UI.

> Note: If the site doesn't load at the URL mysite.test, make sure the Minikube ingress addon is enabled (`minikube addons enable ingress`), and make sure if you `ping mysite.test`, that domain is hitting Minikube's IP and getting a response.
