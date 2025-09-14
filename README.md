# 🚀 Kubernetes Setup and Resource Usage with AWS EKS

This repository contains the setup instructions for creating a workstation and managing an AWS EKS (Elastic Kubernetes Service) cluster.  
The goal is to help you quickly spin up a workstation, create a Kubernetes cluster, deploy resources, and manage them using essential tools.  

🔗 **GitHub Repository**: [Work_Station_Setup_K8s](https://github.com/gsurendhar/Work_Station_Setup_K8s.git)

---

## 📌 Prerequisites

Before starting, ensure you have the following:

- An **AWS account** with permissions to create EKS clusters, IAM roles, VPCs, and EC2 instances.
- **AWS Access Key** and **Secret Key** (to configure AWS CLI).

---

## ⚙️ Step 1: Create Workstation Instance

1. Launch an **EC2 instance** (RHEL recommended).
2. SSH into the instance.
3. Install the required tools:
    - docker
    - aws-cli
    - eksctl
    - kubectl
    - kubens
    - k9s

4. Install **eksctl** (EKS cluster provisioning tool):

   ``` 
   curl --silent --location "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
   sudo mv /tmp/eksctl /usr/local/bin
   ```

5. Install **kubens** (namespace switcher):

   ``` 
   curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
   chmod +x kubens
   sudo mv kubens /usr/local/bin/
   ```

6. Install **k9s** (terminal UI for Kubernetes):

   ``` 
   curl -sS https://webinstall.dev/k9s |  
   ```

---

## 🔑 Step 2: Configure AWS Credentials

Add your AWS Access Key and Secret Key:

``` 
aws configure
```

Provide:

* AWS Access Key ID
* AWS Secret Access Key
* Default region (e.g., `us-east-1`)
* Default output format (`json`)

---

## ☸️ Step 3: Create EKS Cluster

1. Define your EKS cluster configuration in `eks_creation.yaml`.
   Example:

```  
   apiVersion: eksctl.io/v1alpha5
   kind: ClusterConfig

   metadata:
     name: my-cluster
     region: ap-south-1

    ManagedNodeGroup:
    - name: roboshop
        instanceType: ["m5.large", "c3.large","c4.large", "c5.large"]
        desiredCapacity: 2
        spot: true
```

2. Create the cluster:

```
   eksctl create cluster --config-file=eks_creation.yaml
```

---

## 🖥️ Step 4: Verify Cluster and Nodes

* List nodes:

``` 
  kubectl get nodes
```

---

## 📦 Step 5: Deploy Resources

1. Create resources using a manifest file:

``` 
   kubectl apply -f manifest.yaml
```

2. List pods:

   ``` 
   kubectl get pods
   ```

3. Get detailed info about a pod:

   ``` 
   kubectl describe pod <pod-name>
   ```

---

## 🗑️ Step 6: Delete Resources

* Delete resources from a manifest:

  ``` 
  kubectl delete -f manifest.yaml
  ```

* Delete the entire cluster:

  ``` 
  eksctl delete cluster --config-file=eks_creation.yaml
  ```

---

## 🔍 Helpful Tools

* **kubens** → Quickly switch between namespaces
* **k9s** → Interactive terminal UI to view pods, logs, and cluster activity

---

## 📖 Additional Recommendations

* Use **IAM roles** for service accounts instead of long-lived AWS keys for security.
* Create separate namespaces for different environments (e.g., `dev`, `staging`, `prod`).
* Enable logging and monitoring with **CloudWatch** and **Prometheus/Grafana**.
* Store Kubernetes manifests in Git for GitOps-style deployments.

---

## 📝 Summary of Commands

| Action                         | Command                                                 |
| ------------------------------ | ------------------------------------------------------- |
| Create EKS cluster             | `eksctl create cluster --config-file=eks_creation.yaml` |
| List nodes                     | `kubectl get nodes`                                     |
| Apply a manifest               | `kubectl apply -f manifest.yaml`                        |
| List pods                      | `kubectl get pods`                                      |
| Describe a pod                 | `kubectl describe pod <pod-name>`                       |
| Delete resources from manifest | `kubectl delete -f manifest.yaml`                       |
| Delete cluster                 | `eksctl delete cluster --config-file=eks_creation.yaml` |

---

## 📌 Repository Link

👉 [Work\_Station\_Setup\_K8s](https://github.com/gsurendhar/Work_Station_Setup_K8s.git)

---

💡 With this setup, you can easily spin up an EKS cluster, deploy workloads, and manage resources using Kubernetes best practices.
