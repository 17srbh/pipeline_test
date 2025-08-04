**Key Architecture & Workflow Highlights in Swarm Cluster:**
**Cluster Setup:**

Built a Docker Swarm Cluster with 1 manager and multiple worker nodes.

All nodes were secured using firewalls and Docker overlay networking for container communication.

Jenkins CI/CD Pipeline:

Custom Jenkins image built with multi-stage Dockerfile, containing:

Only essential tools and binaries required for CI/CD operations.

Removed unused packages to reduce image surface area and minimize vulnerability exposure.

Periodic vulnerability scans using trivy or similar tools to validate image hygiene.

**Pipeline Flow:**

Code pushed to Git triggers the Jenkins pipeline.

Jenkins builds, tests, and pushes Docker images to a registry.

Images are deployed to the Swarm cluster using docker service commands via Jenkins scripts.

**Secrets Management:**

Sensitive credentials (e.g., DB passwords, API keys) stored and deployed using Docker Swarm Secrets.

Jenkins interacts with secrets only during deploy, ensuring no hardcoded values in the pipeline.

**Security & Maintenance:**

Jenkins agent containers use read-only volumes, unprivileged users, and ephemeral credentials.

No package managers or shell access included in final Jenkins image to avoid runtime tampering.

Reduced attack surface = fewer patches required.

**Resilience & Monitoring:**

Services set to restart automatically on failure (--restart-condition on-failure).

System logs and service metrics forwarded to centralized logging/monitoring stack (ELK or Prometheus optional).



2) ****Extension of the project in Kubernetes Cluster ****

Created dedicated namespace for the Dev team (dev-namespace) to isolate resources.

Configured RBAC roles and role bindings to provide namespace-scoped permissions (no cluster-level rights).

Used Kubernetes secrets to store Docker credentials and private repo keys, referenced in Jenkins builds.

Jenkins Master was deployed via a custom Helm chart in the ci-cd namespace, connected to the cluster via kubectl config set-context.

Jenkins agents used Kubernetes plugin to dynamically spawn pods inside the pipeline's namespace.

Integrated GitHub + Jenkins for webhook-based builds, and deployed apps using kubectl apply or Helm within dev namespaces.

**Security Considerations**

Multi-stage Jenkins image was scanned regularly for CVEs (minimal base image like alpine or distroless).

Jenkins credentials were mounted as Kubernetes secrets or Swarm secrets, never hard-coded.

Role-based access control ensured that developers couldn’t access resources outside their scope.

Used NetworkPolicies (K8s) and --publish controls (Swarm) to limit service exposure.



















































