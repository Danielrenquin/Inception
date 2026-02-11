# Inception

A multi-service containerized project using Docker. It deploys three modern services: Nginx as a reverse proxy, MariaDB as the database, and WordPress as the frontend application.  
The purpose of this project was to build a reproducible and isolated environment. Each service runs in its own container, and they are connected to form a reverse proxy architecture, reflecting a production-like setup.

---

# Containerized vs Virtualized

Virtualization: allows running multiple virtual machines on the same server. 
Each VM behaves as an independent computer, with its own resources and operating system.

Containerization: is different: each container runs one or more processes, and while containers are isolated, they share the same operating system. 
This makes containers lighter to deploy and faster to start than virtual machines.

# Secret Vs Environment Variables

Secret: are designed to store sensitive data such as passwords or API keys. 
        They are handled separately from application configuration and are not directly exposed 
        in the container environment. Secrets provide a higher level of security by limiting 
        visibility and access to critical information.

Environment Variables: are configuration values defined in a .env file and injected into containers at runtime.
                       They are commonly used to configure application behavior (database name, user, ports, etc.).
                       While convenient and widely supported, environment variables can be exposed 
                       through container inspection and are therefore less secure for highly sensitive data.

# Docker Network vs Host Network

Docker Network: Provides isolation between containers and allows controlled communication
                using internal DNS and service names. Improves security and portability.

Host Network: Containers share the host’s network stack, offering better performance
              but reduced isolation and higher security risks.

# Docker Volumes vs Bind Mounts

Docker Volumes: Managed by Docker and stored in a dedicated area. 
                They are portable, easier to back up, and safer for persistent data.
Bind Mounts: Map a host directory directly into a container. 
             Useful for development but less portable and more dependent on host filesystem structure.

---

# Use of AI

In this project, AI was useful specifically for configuring the `.conf` files and for working with some Bash commands that I had never used before.
It helped me understand how to approach the project efficiently and structure the multi-service environment correctly.

---

# Sources

YouTube ([EvoluNoob], [Korben], [NetworkChuck], [Articulated Robotics]), OpenClassrooms, [nginx.org](https://nginx.org/), [hub.docker.com](https://hub.docker.com/), www.php.net, https://mariadb.com 
