
# Logitechmediaserver 7.9.1
# 
#
FROM ubuntu:14.04
MAINTAINER Tom Deckers <tom@ducbase.com>

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install supervisor wget git libio-socket-ssl-perl flac

# Install logitechmediaserver
#############################
RUN wget -O /tmp/logitechmediaserver_all.deb \
    $(wget -q -O - "http://www.mysqueezebox.com/update/?version=7.9.1&revision=1&geturl=1&os=deb") \
    && dpkg -i /tmp/logitechmediaserver_all.deb

# Add pipework to wait for network if needed
ADD files/pipework /usr/local/bin/pipework
RUN chmod +x /usr/local/bin/pipework

# Configure supervisor to run logitechmediaserver
ADD files/supervisord.conf /etc/supervisor/supervisord.conf
ADD files/lms.conf /etc/supervisor/conf.d/lms.conf
ADD files/boot.sh /usr/local/bin/boot.sh
RUN chmod +x /usr/local/bin/boot.sh

# Restart lms on network up.  Needed when starting with --net="none" to add network later.
ADD files/lms-restart /etc/network/if-up.d/lms-restart
RUN chmod +x /etc/network/if-up.d/lms-restart

RUN rm -rf /tmp/*

# supervisor
EXPOSE 9001
# logitechmediaserver
EXPOSE 9000 9090 3483

CMD ["/usr/local/bin/boot.sh"]
