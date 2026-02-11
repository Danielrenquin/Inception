*This project has been created as part of the 42 curriculum by daniel.*

# Inception

## Description
Inception is a system administration project that builds a small, production‑like stack using Docker. The infrastructure is composed of three services: Nginx (TLS reverse proxy), WordPress (PHP‑FPM), and MariaDB (database). Each service runs in its own container and communicates over a private Docker network.

## Instructions
### Prerequisites
- Docker and Docker Compose installed
- A Linux VM (as required by the subject)
- The domain name mapped to your local IP (e.g., in /etc/hosts)

### Build and run
- Build and start: make all
- Stop containers: make down
- Stop and remove containers + volumes: make clean
- Full cleanup (containers, images, volumes): make fclean

### Access
- Website: https://daniel.42.fr
- WordPress admin panel: https://daniel.42.fr/wp-admin

## Project Description
### Use of Docker
This project uses Docker to isolate services, ensure reproducibility, and simplify deployment. Each service has its own Dockerfile and is orchestrated by Docker Compose. Persistent data is stored in named volumes placed under /home/daniel/data.

### Main design choices
- Separate containers for Nginx, WordPress (PHP‑FPM), and MariaDB
- Private bridge network for internal service communication
- TLS‑only entrypoint on port 443
- Secrets stored outside the repository and injected via Docker secrets

### Comparisons
- Virtual Machines vs Docker: VMs run full OS instances and are heavier; containers share the host kernel and start faster while remaining isolated.
- Secrets vs Environment Variables: Secrets are designed for sensitive data and are not exposed in container inspection; environment variables are convenient but less secure for passwords.
- Docker Network vs Host Network: Docker networks isolate traffic and allow service discovery; host networking removes isolation and increases risk.
- Docker Volumes vs Bind Mounts: Volumes are managed by Docker and portable; bind mounts depend on host paths and are less portable.

## Resources
- Official docs: https://docs.docker.com, https://nginx.org, https://mariadb.com, https://wordpress.org
- Community references: OpenClassrooms, NetworkChuck

### AI usage
AI was used to review configuration files, improve documentation structure, and check Docker best practices. All suggestions were verified and adapted manually.