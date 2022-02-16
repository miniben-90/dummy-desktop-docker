#Using focal version of Ubuntu
FROM ubuntu:focal

#Install required dep for xdummy and mysql-workbench
RUN \
  echo "....install packages...." && \
  DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install --no-install-recommends -y \
  lsb-release \
  xvfb \
  locales \
  yaru-theme-icon \
  libproj15 \
  libatk1.0-0 \
  libatkmm-1.6-1v5 \
  libcairo2 \
  libgdk-pixbuf2.0-0 \
  libgl1 \
  libglib2.0-0 \
  libglibmm-2.4-1v5 \
  libgssapi-krb5-2 \
  libgtk-3-0 \
  libgtk2.0-0 \
  libgtkmm-3.0-1v5 \
  libmysqlclient21 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libpcrecpp0v5 \
  libpng16-16 \
  libpython2.7 \
  libsecret-1-0 \
  libsigc++-2.0-0v5 \
  libsqlite3-0 \
  libssh-4 \
  libssl1.1 \
  libx11-6 \
  libxml2 \
  libzip5 && \
  echo "....cleanup...." && \
  apt-get autoclean -y && \
  apt-get autoremove -y && \
  rm -Rf \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/* && \
  echo "....generate local en_US...." && \
  locale-gen en_US.UTF-8

#Download mysql-workbench
ADD https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.22-1ubuntu20.04_amd64.deb /tmp/

#Installing mysql-owrkbench
RUN \
  echo "....install mysql-workbench...." && \
  dpkg -i /tmp/mysql-workbench-community_8.0.22-1ubuntu20.04_amd64.deb && \
  rm -Rf /tmp/mysql-workbench-community_8.0.22-1ubuntu20.04_amd64.deb

RUN \
  echo "....cleanup...." && \
  apt-get autoclean -y && \
  apt-get autoremove -y && \
  rm -Rf \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/*

#Add Xorg configuration to use dummy desktop
ADD ./config/xorg.conf /usr/share/X11/xorg.conf.d/xorg.conf
ADD ./config/xorg.conf /etc/X11/xorg.conf
#Add command to exec mysql-workbench into virtual desktop
ADD ./scripts/entrypoint.sh /etc/entrypoint
#Make it executable
RUN chmod +x /etc/entrypoint

#Set env display to :0
ENV DISPLAY=:0 \
LANGUAGE="en_US.UTF-8" \
LANG="en_US.UTF-8"

#Create folder
RUN mkdir -p \
/var/mwb/source \
/var/mwb/json \
/var/mwb/preview \
/var/mwb/script

#Set env input & output
ENV MWB_PATH="/var/mwb/source/source.mwb"
ENV MWB_SCHEMA_JSON_OUTPUT="/var/mwb/json/model.json"
ENV MWB_PREVIEW_PATH=""

VOLUME [ "/var/mwb/" ]

ENTRYPOINT [ "/etc/entrypoint" ]
