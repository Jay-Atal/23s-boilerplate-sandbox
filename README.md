# Dreamworks: Transparency between prospective co-op students and employers

## About Dreamworks
Dreamworks is founded on an idea  - transparency of experiences. We enable a job board for co-op students that has specific factors that aren't included in current offerings. Namely, we offer students the ability to view compensation data, prior experience, and difficulty and experience ratings on company job postings. We also allow for companies to assign a representative to be able to respond to postive and negative reviews, and correct informationn about their firm. This additional transparency helps resolve the matching problem when it comes to applying for co-ops, and allows for more placement and better outcomes for all.

__VIDEO LINK__: https://youtu.be/5HKpSLmYiLo

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 




