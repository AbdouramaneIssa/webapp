FROM ubuntu:22.04
LABEL maintainer="training"
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx git
RUN rm -Rf /var/www/html/*
RUN git clone https://github.com/AbdouramaneIssa/PALESTINIAN-HUMANITARIAN-Organization.git /var/www/html/
EXPOSE 80
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]
