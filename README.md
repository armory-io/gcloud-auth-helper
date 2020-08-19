# Helps with renewing Google Cloud authentication tokens

Forked from https://github.com/justinrlee/toys/tree/master/gcloud-auth-helper

Kubeconfig File:

```yaml
contexts:
- context:
    cluster: gke_cluster_name
    user: gke_cluster_name
  name: gke_cluster_name
current-context: gke_cluster_name
kind: Config
preferences: {}
users:
- name: gke_cluster_name
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - /tmp/gcloud/auth_token
      command: /bin/cat
```

Halconfig deploymentEnvironment:

```yml
    sidecars:
      spin-clouddriver:
      - name: token-refresh
        dockerImage: armory/gcloud-auth-helper:stable
        mountPath: /tmp/gcloud
```
