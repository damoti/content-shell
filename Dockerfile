FROM ubuntu:15.10

## Fonts
# add 'add-apt-repository' command and makes https available to apt-get (for msttcorefonts)
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    software-properties-common
# add custom mscorefonts repo
# the official repo pulls ms fonts from sourceforge which almost always fails
RUN add-apt-repository ppa:james-pic/msttcorefonts
# agree to microsoft font end user license agreement
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true\
    | debconf-set-selections
# install fonts
RUN apt-get update && apt-get install -y \
    fonts-thai-tlwg \
    ttf-kochi-gothic \
    ttf-kochi-mincho \
    ttf-indic-fonts \
    ttf-dejavu-core \
    msttcorefonts

## Dart, Chrome, xvfb, utils
# add dart keys
RUN apt-key adv --fetch-keys http://dl.google.com/linux/linux_signing_key.pub && \
    echo 'deb http://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \
    > /etc/apt/sources.list.d/dart.list
# install
RUN apt-get update && apt-get install -y \
    chromium-browser \
    dart \
    unzip \
    wget \
    xauth \
    xvfb
# set dart path
ENV PATH /usr/lib/dart/bin:$PATH

## content-shell
WORKDIR /usr/local/content_shell
RUN wget https://storage.googleapis.com/dart-archive/channels/stable/release/latest/dartium/content_shell-linux-x64-release.zip
RUN unzip content_shell-linux-x64-release.zip \
  && rm content_shell-linux-x64-release.zip \
  && mv $(ls) latest
ENV PATH /usr/local/content_shell/latest:$PATH

ENV PUB_CACHE .pub-cache
ENTRYPOINT xvfb-run -s '-screen 0 1024x768x24' pub run test -p content-shell $0
CMD ["-r expanded test/"]
