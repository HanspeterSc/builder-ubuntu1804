FROM ubuntu:18.04
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install make git-core build-essential gcc g++
RUN git clone --depth=1 https://github.com/linux-test-project/lcov.git /tmp/lcov\
 && cd /tmp/lcov && make && make install

FROM ubuntu:18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractve apt-get -y install \
    uidmap gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping libsdl1.2-dev xterm tar locales pxz cmake gdb\
    libboost-all-dev ninja-build qt5-default git libqt5serialport5-dev libqt5charts5-dev \
    qtdeclarative5-dev qtdeclarative5-private-dev libqt5websockets5-dev libqt5test5 \
    libqt5svg5-dev qtquickcontrols2-5-dev qtbase5-private-dev libqt5x11extras5-dev libqt5xml5 \
    qml-module-qtqml-statemachine qml-module-qt-labs-settings qml-module-qt-labs-platform \
    qml-module-qtquick-controls2 qml-module-qtquick2 qml-module-qttest libx11-xcb-dev \
    libssl-dev libxml2-dev xvfb p7zip-full tzdata libxss-dev libkf5networkmanagerqt-dev 

COPY --from=0 /usr/local /usr/local

RUN locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN echo "#/bin/sh\\n/usr/bin/xvfb-run -a -s '-screen 0 800x600x24+32' \$@" > /usr/bin/xvfb_run
RUN chmod +x /usr/bin/xvfb_run

RUN useradd -ms /bin/bash user

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["cat"]
