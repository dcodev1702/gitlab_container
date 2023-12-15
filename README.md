# GitLab Container (Docker Compose)
A GitLab implementation using: 
* Docker Compose
* Self-Signed SSL Certificates
* GitLab Runner for CI/CD

# GitLab Setup
* modify .env and docker-compose.yml as required
```console
docker-compose up -d
```

# Configure & Run GitLab Runner
  * [Must Read for Self-Signed SSL Certs](https://docs.gitlab.com/runner/configuration/tls-self-signed.html)
  * Acquire gitlab runner registration token from GitLab 
    * GOTO: Your Project -> Settings -> CI/CD -> Runner -> click virtical 3 dots -> copy / paste
    ![image](https://github.com/dcodev1702/gitlab_container/assets/32214072/ee161287-1e92-4572-8792-8677d213b6bc)


# Modify gitlabUrl & hostAliases as required
# helm repo add gitlab https://charts.gitlab.io
# helm repo update gitlab
# kubectl create ns gitlab
# kubectl create -f gitlab_runner_configmap.yml
# kubectl create -f fuse-device-plugin-k8s-1.16.yml
# helm install --namespace gitlab gitlab-runner -f ./gitlab_runner_values.yml gitlab/gitlab-runner

# [if needed: helm uninstall --namespace gitlab gitlab-runner]
