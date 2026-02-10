# Configuration overview

| Service   | Role / Function                | Dependencies | Port (internal) | Port (external) |
| --------- | ------------------------------ | ------------ | --------------- | --------------- |
| Nginx     | Reverse proxy                  | WordPress    | 443             | 443             |
| WordPress | Frontend app                   | MariaDB      | 9000            | -               |
| MariaDB   | Database backend               | -            | 3306            | -               |

---

# The srcs directory

Inside the srcs directory, you will find the docker-compose.yml file and a requirements directory.  
The requirements directory contains one subdirectory per service. Each service directory has the following structure:

  - conf directory containing configuration files  
  - tools directory containing bash scripts  
  - Dockerfile which builds the container and sets the bash script as the entrypoint to initialize the service

---

# Makefile

- build: build the images Docker from the Dockerfiles.
- up: launch the containers.
- all: "make build" + "make up".
- down: stop and delete the containers and keep volumes.
- clean: delete the containers and the volumes only images are keep.
- fclean: full cleaning of the structure.
- re: "make fclean" + "make all".
- logs: print the logs of the containers in real time.

---

# Nginx

- Dockerfile: The dockerfile download openssl and nginx.
              Replace the original nginx conf by my own nginx conf.
              Give the right to execute.
              Expose port 443 and launch the bash script as pid1.

- bash script: Make a directory for the ssl key.
               Create a auto signed TLS certificat with OpenSSL.
               Check if the configuration of nginx is valide.
               Launch nginx as pid 1.

- nginx.conf: The configuration is going to choose the number of worker
              depend of the number of cpu available.
              The type of file is reconize the file by using MIME(Multipurpose, Internet, Mail, Extensions).
              If the folder is not reconize is treat as binary file.
              Nginx serves static files from /var/www/html,
              routes URLs to WordPress via index.php,
              and delegates the execution of PHP files to PHP-FPM.

---

# Wordpress

- Dockerfile: Installs PHP-FPM and required PHP extensions. curl is used
              to download WordPress, and ca-certificates allows HTTPS
              downloads. The cache is cleaned to reduce image size.
              The default PHP-FPM pool configuration is replaced by a
              custom www.conf. The entrypoint script is made executable,
              port 9000 is exposed, and the setup script is used as PID 1.
    
- bash script: Sets the WordPress path to /var/www/html. If WordPress is
               not present, it is downloaded and configured. Finally,
               php-fpm8.2 is started in the foreground.

- www.conf: Defines a PHP-FPM pool (a group of PHP worker processes) with
            a minimal configuration for this project.
  
---

# mariadb

- Dockerfile: Installs mariadb-server and mariadb-client, then cleans the
              cache to reduce image size. It prepares the data, runtime, and
              log directories with correct ownership for the mysql user. The
              default configuration is replaced by a custom mariadb.conf. The
              entrypoint script is made executable, port 3306 is exposed, and
              the setup script is used as PID 1.

- bash script: Creates required directories, initializes the database if it
               does not exist, and starts MariaDB temporarily to apply the
               initial SQL setup (root password, database, and users). It then
               shuts down the temporary instance and starts MariaDB in the
               foreground as PID 1.

- mariadb.conf: Sets the server to listen on 0.0.0.0:3306 for Docker networking,
                defines the datadir and socket paths, configures basic
                performance limits, enables error logging, and enforces the
                utf8mb4 character set for full Unicode support.

  ---

# Some technical comparaison

/*Virtual Machine vs Containerization*/

-Virtual Machine :  A virtual machine runs its own independent operating system
                    and uses resources allocated from the host machine. 
                    It behaves like a fully independent computer inside the host. 
                    Because it requires its own boot process, 
                    starting a virtual machine is relatively slow.

-Containerization : Containerization allows applications to run as isolated units
                    while sharing the host operating system. 
                    Since containers do not require a full OS boot process, 
                    they start much faster than virtual machines.

/*Secrets vs Environment Variable*/












  


