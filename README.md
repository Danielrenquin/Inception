# Inception

A multi-service containerized project using Docker. It deploys three modern services: Nginx as a reverse proxy, MariaDB as the database, and WordPress as the frontend application.  
The purpose of this project was to build a reproducible and isolated environment. Each service runs in its own container, and they are connected to form a reverse proxy architecture, reflecting a production-like setup.

---

# Containerized vs Virtualized

Virtualization: allows running multiple virtual machines on the same server. 
Each VM behaves as an independent computer, with its own resources and operating system.

Containerization: is different: each container runs one or more processes, and while containers are isolated, they share the same operating system. 
This makes containers lighter to deploy and faster to start than virtual machines.

---

# Use of AI

In this project, AI was useful specifically for configuring the `.conf` files and for working with some Bash commands that I had never used before.
It helped me understand how to approach the project efficiently and structure the multi-service environment correctly.

---

# Sources

YouTube ([EvoluNoob], [Korben], [NetworkChuck], [Articulated Robotics]), OpenClassrooms, [nginx.org](https://nginx.org/), [hub.docker.com](https://hub.docker.com/)
