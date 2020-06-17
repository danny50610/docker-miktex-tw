FROM ubuntu:bionic

LABEL Description="Dockerized MiKTeX, Ubuntu 18.04" Vendor="Christian Schenk" Version="2.9.6990"

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
           apt-transport-https \
           ca-certificates \
           dirmngr \
           ghostscript \
           gnupg \
           gosu \
           make \
           perl \
           fonts-arphic-uming fonts-arphic-ukai fonts-noto-cjk

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
RUN echo "deb http://miktex.org/download/ubuntu bionic universe" | tee /etc/apt/sources.list.d/miktex.list

RUN    apt-get update \
    && apt-get install -y --no-install-recommends \
           miktex

RUN    miktexsetup finish \
    && initexmf --admin --set-config-value=[MPM]AutoInstall=1 \
    && mpm --admin --update-db \
    && mpm --admin \
           --install amsfonts \
           --install biber-linux-x86_64 \
           --install standalone \
           --install iftex \
           --install etoolbox \
           --install ifplatform \
           --install fontspec \
           --install geometry \
           --install xcolor \
           --install titlesec \
           --install fancyhdr \
           --install setspace \
           --install tocbibind \
           --install biblatex \
           --install csquotes \
           --install pdfpages \
           --install caption \
           --install placeins \
           --install eso-pic \
           --install background \
           --install everypage \
           --install multirow \
           --install colortbl \
           --install floatrow \
           --install amsmath \
           --install siunitx \
           --install mhchem \
           --install todonotes \
           --install listingsutf8 \
           --install url \
           --install hyperref \
           --install cleveref \
    && initexmf --admin --update-fndb

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

ENV MIKTEX_USERCONFIG=/miktex/.miktex/texmfs/config
ENV MIKTEX_USERDATA=/miktex/.miktex/texmfs/data
ENV MIKTEX_USERINSTALL=/miktex/.miktex/texmfs/install

WORKDIR /miktex/work

CMD ["bash"]
