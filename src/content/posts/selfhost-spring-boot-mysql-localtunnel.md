----------
title: On Budget Self-Host Spring Boot MySQL  
published: 2025-02-03  
description: "A guide on setting up a self-hosted Spring Boot app with MySQL using Docker and Localtunnel without spending on domain names or dedicated servers."  
image: "https://user-images.githubusercontent.com/45159366/152699307-1c4ebfcd-a2b0-456c-9a84-01ac255e3782.png"  
tags: [Java, Spring Boot, Self Host, Docker, MySQL]  
category: 'Technology'  
draft: false  
lang: "en"
----------

Setting up your own self-hosted environment for web applications doesn’t need to be expensive or complicated. In this guide, I’ll walk you through how to self-host a **Spring Boot** application connected to a **MySQL** database using **Docker** and **Localtunnel**. The beauty of this setup lies in its simplicity and cost-effectiveness. No need to buy a domain or dedicated server—just your local machine and a few handy tools.

With **Localtunnel**, you can easily expose your local development environment to the internet via a publicly accessible URL. This guide will help you set up everything from scratch and use your **public IP** with **Localtunnel** for accessing your Spring Boot app externally.

## Prerequisites

-   **Docker**: Ensure Docker is installed on your machine. If not, follow the official [Docker installation guide](https://docs.docker.com/get-docker/).
-   **Spring Boot Application**: This guide assumes you already have a Spring Boot application ready to go. If not, you can easily create one using Spring Initializr.
-   **MySQL Database**: We will use MySQL for this example, but you can easily swap it out for any other database if needed.
-   **Localtunnel**: This tool is used to expose your local server to the internet. You can install it via npm (`npm install -g localtunnel`).

### The Project Setup

In this setup, we’ll create a simple Dockerized environment for your Spring Boot application and MySQL database. Additionally, we will use **Localtunnel** to forward traffic from the public URL to your local Spring Boot application.

Here’s how we structure it:

1.  **MySQL Database** – Running inside a Docker container.
2.  **Spring Boot Application** – Running in a Docker container connected to the MySQL database.
3.  **Localtunnel** – Exposes the Spring Boot app to the internet using a public URL.

### Docker Compose Configuration

We will use Docker Compose to define the services (MySQL and Spring Boot) and set them up for easy deployment.

```yaml
networks:  
  my_network:  
    driver: bridge  
  
services:  
  db:  
    image: lcaohoanq/sample-mysql-db:2.0  
    container_name: mysql-db  
    ports:  
      - "3311:3306" # Host port 3311 -> Container port 3306 (MySQL)  
  env_file:  
      - .env          # Include your MySQL environment variables here  
  volumes:  
      - db_data:/var/lib/mysql  # Persistent volume for MySQL data  
  networks:  
      - my_network  
    healthcheck:  
      test:  
        [  
          "CMD",  
          "mysqladmin",  
          "ping",  
          "-h",  
          "localhost",  
          "-u",  
          "root",  
          "--password=Luucaohoang1604^^",  
        ]  
      interval: 10s  
      timeout: 5s  
      retries: 5  
  
  springboot-app:  
    container_name: springboot-app  
    build:  
      context: .  
      dockerfile: Dockerfile  
    restart: on-failure  
    networks:  
      - my_network  
    ports:  
      - "8080:8080" # Host port 8080 -> Container port 8080 (Spring Boot)  
  depends_on:  
      - db            # Ensure Spring Boot app waits for MySQL to be ready  
  env_file:  
      - .env          # Use the same .env file for database credentials  
  environment:  
      - SPRING_DATASOURCE_URL=jdbc:mysql://db:3306/${MYSQL_DATABASE} # Use the MySQL service name as the hostname  
  - SPRING_DATASOURCE_USERNAME=${MYSQL_USER}  
      - SPRING_DATASOURCE_PASSWORD=${MYSQL_PASSWORD}  
    
  nginx:  
    image: nginx:latest  
    container_name: nginx-proxy  
    ports:  
      - "80:80" # Expose Nginx on port 80  
  volumes:  
      - ./nginx.conf:/etc/nginx/nginx.conf  # Custom Nginx configuration file  
  depends_on:  
      - springboot-app  
    networks:  
      - my_network  
        
  portainer:  
    image: portainer/portainer-ce:latest  
    container_name: portainer  
    ports:  
      - "9443:9443"  
  volumes:  
      - data:/data  
      - /var/run/docker.sock:/var/run/docker.sock  
    restart: unless-stopped  
  
volumes:  
  db_data:  # Docker volume to persist MySQL data  
  data:     # Docker volume to persist Portainer data

```

### How It Works

1.  **MySQL Database Service** (`db`):
    
    -   Runs MySQL in a container with persistent data stored in a Docker volume.
    -   Exposes port `3306` internally and maps it to port `3311` on the host.
2.  **Spring Boot Application Service** (`springboot-app`):
    
    -   Your Spring Boot app runs in a Docker container connected to the MySQL container.
    -   The application listens on port `8080`.
3.  **Optional** (`portainer`): Help Docker management more ease

### Setting Up Localtunnel

Now comes the fun part! To expose your Spring Boot app to the public internet, we’ll use **Localtunnel**. This will create a publicly accessible URL that tunnels to your local machine.

1.  **Start the Docker containers**:
    
    First, make sure your containers are up and running with:
    
    ```bash
    docker-compose up -d
    ```
	   - Or this, if you need to integrate with CI-CD pipeline
    ```bash
	docker compose -f docker-compose.yml up -d --build --remove-orphans
    ```
    
2.  **Install Localtunnel**:
    
    If you haven't installed Localtunnel yet, you can do so globally using npm: [Document here](https://theboroer.github.io/localtunnel-www/)
    
    ```bash
    npm install -g localtunnel
    ```
    
3.  **Expose the Spring Boot application**:
    
    Use Localtunnel to expose your app running on `localhost:8080`:
    
    ```bash
    lt --port 8080
    ```
    
    This will give you a URL like `https://example.loca.lt`, which is publicly accessible from anywhere.
    
  4. **Provide Password to access**: 
 
 - Usually the password is the server's public IP address

### Accessing the App

-   To access your Spring Boot app locally, visit `http://localhost:8080`.
-   To access it externally, use the **Localtunnel URL** (e.g., `https://example.loca.lt`), and your Spring Boot app will be accessible from anywhere.

### Setting Up Environment Variables

Ensure your `.env` file includes the necessary environment variables for MySQL and Spring Boot:

```bash
MYSQL_ROOT_PASSWORD=Luucaohoang1604^^  
MYSQL_DATABASE=mysql_starter  
MYSQL_PASSWORD=Luucaohoang1604^^  
MYSQL_USER=root  
DB_USERNAME=root
```

### Conclusion

By using **Docker** to manage your containers and **Localtunnel** to expose your local Spring Boot application, you can easily self-host your web app without the need for a domain name or expensive hosting solutions. This setup is perfect for development, testing, or even small production environments where cost is a concern.

With just a few tools, you’ve created a fully functional self-hosted application that can be accessed from anywhere—without breaking the bank!

----------