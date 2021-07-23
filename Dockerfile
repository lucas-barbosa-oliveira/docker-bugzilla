FROM ubuntu:focal

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y netcat apache2 libappconfig-perl \
  libdate-calc-perl libtemplate-perl build-essential libdatetime-timezone-perl \
  libdatetime-perl libemail-sender-perl libemail-mime-perl libemail-mime-modifier-perl \
  libdbi-perl libdbd-mysql-perl libcgi-pm-perl libmath-random-isaac-perl \
  libmath-random-isaac-xs-perl libapache2-mod-perl2 \
  libapache2-mod-perl2-dev libchart-perl libxml-perl libxml-twig-perl perlmagick \
  libgd-graph-perl libtemplate-plugin-gd-perl libsoap-lite-perl libhtml-scrubber-perl \
  libjson-rpc-perl libdaemon-generic-perl libtheschwartz-perl libtest-taint-perl \
  libauthen-radius-perl libfile-slurp-perl libencode-detect-perl libmodule-build-perl \
  libnet-ldap-perl libauthen-sasl-perl libfile-mimeinfo-perl \
  libhtml-formattext-withlinks-perl libfile-which-perl libgd-dev libmysqlclient-dev \
  lynx-common lynx sphinx-doc sphinx-common graphviz rst2pdf && \
  rm -rf /var/lib/apt/lists/* 

# Remove DEFAULT apache site
RUN rm -rf /var/www/html

# Make Bugzilla install Directory
ADD https://ftp.mozilla.org/pub/mozilla.org/webtools/bugzilla-5.0.6.tar.gz /tmp/
RUN tar -xvf /tmp/bugzilla-5.0.6.tar.gz -C /var/www/
RUN ln -s /var/www/bugzilla-5.0.6 /var/www/html
ADD bugzilla.conf /etc/apache2/sites-available/
WORKDIR /var/www/html
ADD params data/params
ADD localconfig .

RUN ./checksetup.pl --check-modules ; \
  /usr/bin/perl install-module.pl --all ; \
  /usr/bin/perl install-module.pl Net::SMTP::SSL ; \
  /usr/bin/perl install-module.pl IO::Socket::SSL; \
  ./checksetup.pl ; \
  a2enmod cgi headers expires && \
  a2ensite bugzilla && \
  a2dissite 000-default && \
  a2enmod rewrite

# Add the start script
ADD start /opt/

# Run start script
CMD ["/opt/start"]

# Expose web server port
EXPOSE 80
