FROM nimmis/java-centos:openjdk-8-jdk

MAINTAINER Ken He <kenhosr@gmail.com>


ENV SCREEN_WIDTH 1200
ENV SCREEN_HEIGHT 900
ENV SCREEN_DEPTH 16 
ENV DISPLAY :99

RUN yum install -y xorg-x11-server-Xvfb.x86_64

RUN wget http://chrome.richardlloyd.org.uk/install_chrome.sh

RUN chmod u+x install_chrome.sh

RUN ./install_chrome.sh -f

RUN dbus-uuidgen > /etc/machine-id

ADD SeleniumGridExtras-jar-with-dependencies.jar /opt/selenium/SeleniumGridExtras-jar-with-dependencies.jar
ADD hub_4444.json /opt/selenium/hub_4444.json
ADD node_5555.json /opt/selenium/node_5555.json
ADD selenium_grid_extras_config.json /opt/selenium/selenium_grid_extras_config.json
ADD entry_point.sh /opt/bin/entry_point.sh

RUN chmod +x /opt/bin/entry_point.sh

EXPOSE 3000
EXPOSE 4444

WORKDIR /opt/selenium/

CMD ["/opt/bin/entry_point.sh"]
