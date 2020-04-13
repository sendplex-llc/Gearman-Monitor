# Dockerfile: Automator


Notes:
- LAMP
- PHP 7.2
- Exposed ports: ssh, http, https

Initiation
1) Edit config file
2) docker build -t automator.
3) docker run -d --name automator automator:latest
4) check if it's working, docker exec -it automator bash -c "dir /var/log", this should show a file called Deploy.log, there is a 3 minute delay after initiation.
