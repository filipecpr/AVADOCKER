# Example using Dockerfile and docker-compose.yml

This project uses a Dockerfile to build a example Docker image and a example Docker Compose that uses this builded image.

The builded image extends our another image, `ctezlifrn/moodle`, configure somes languages (en, es, pt), extra PHP ini settings and then download and install some plugins to your reference.

The Docker Compose file setups a environment with 4 services: Redis (only for session), PostgreSQL, Moodle (for web interface) and cron. On this example web and cron share volume './volumes/moodledata'.
#   A V A D O C K E R  
 