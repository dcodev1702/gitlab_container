# GitLab Container (Docker Compose)
A GitLab implementation using: 
* Docker Compose
* Self-Signed SSL Certificates
* GitLab Runner for CI/CD

# GitLab Setup
* Modify .env and docker-compose.yml as required
```console
docker-compose up -d
```

# Configure & Run GitLab Runner
  * Generate SSL Self-Signed Certificates from the "certs" directory
  * [Must Read for Self-Signed SSL Certs](https://docs.gitlab.com/runner/configuration/tls-self-signed.html)
    ![image](https://github.com/dcodev1702/gitlab_container/assets/32214072/d2369248-6ead-49d7-b784-f0d39a0667eb)

  * Acquire gitlab runner registration token from GitLab 
    * GOTO: Your Project -> Settings -> CI/CD -> Runner -> click virtical 3 dots -> copy / paste
    ![image](https://github.com/dcodev1702/gitlab_container/assets/32214072/ee161287-1e92-4572-8792-8677d213b6bc)

  * Copy / Paste ca.crt contents into gitlab_runner_configmap.yml
    
  * Modify gitlabUrl and hostAliases as required
  ![image](https://github.com/dcodev1702/gitlab_container/assets/32214072/d1dc3110-8a97-4a0e-8576-ec9ff5a9ed54)

  ```console
  helm repo add gitlab https://charts.gitlab.io
  helm repo update gitlab
  kubectl create ns gitlab
  ```

 kubectl create -f gitlab_runner_configmap.yml
 kubectl create -f fuse-device-plugin-k8s-1.16.yml
 helm install --namespace gitlab gitlab-runner -f ./gitlab_runner_values.yml gitlab/gitlab-runner

 Uninstall Helm Chart:
 ```console
 helm uninstall --namespace gitlab gitlab-runner
 ```
