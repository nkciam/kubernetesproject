FROM centos:latest
MAINTAINER chung,daiangclubs@gmail.com
RUN sudo su -
RUN apt update
RUN apt install apache2
RUN apt install zip
RUN apt install unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page258/loxury.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip loxury.zip
RUN cp -rvf loxury/* .
RUN rm -rf loxury loxury.zip
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
