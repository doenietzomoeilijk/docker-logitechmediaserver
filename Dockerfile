
# Logitechmediaserver 7.8.0
# 
#
FROM ubuntu:14.04
MAINTAINER Tom Deckers <tom@ducbase.com>

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install supervisor wget git 

# Install logitechmediaserver
#############################

RUN wget -O /tmp/logitechmediaserver_7.8.0_all.deb http://downloads.slimdevices.com/LogitechMediaServer_v7.8.0/logitechmediaserver_7.8.0_all.deb
RUN dpkg -i /tmp/logitechmediaserver_7.8.0_all.deb

# create directory for music - can be mapped using docker -v
RUN mkdir /media

# Configure supervisor to run logitechmediaserver
ADD files/supervisord.conf /etc/supervisor/supervisord.conf
ADD files/squeezeserver.conf /etc/supervisor/conf.d/squeezeserver.conf

RUN rm -rf /tmp/*

# supervisor
EXPOSE 9001
# logitechmediaserver
EXPOSE 9000 9090 3483

CMD /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
