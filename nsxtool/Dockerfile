FROM ubuntu:16.04

RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       cmake \
       git \
       g++ \
       ninja-build \
       libboost-date-time-dev \
       libboost-filesystem-dev \
       libboost-test-dev\
       libeigen3-dev \
       libhdf5-dev \
       libtiff5-dev \
       libfftw3-dev \
       libgsl-dev \
       qtbase5-dev \
       libqt5opengl5-dev \
       python3-dev \
       python3-numpy \
       swig \
       libyaml-cpp-dev \
    && apt-get autoclean \
    && apt-get autoremove

RUN GIT_SSL_NO_VERIFY=true git clone -b develop https://code.ill.fr/scientific-software/nsxtool.git

WORKDIR /nsxtool/build

RUN cmake -G "Ninja" -DCMAKE_BUILD_TYPE=Release -DBUILD_QTAPPS=ON -DCMAKE_INSTALL_PREFIX=./ -DBUILD_GSL=ON -DNSX_PYTHON3=ON ..
RUN cmake --build . --config Release
RUN cmake --build . --config Release --target install

RUN export NSX_ROOT_DIR=/nsxtool/build/share/nsxtool

RUN ninja test

RUN cmake -G "Ninja" -DCMAKE_BUILD_TYPE=Release -DBUILD_QTAPPS=ON -DBUILD_DEBIAN=ON -DCMAKE_INSTALL_PREFIX=./ -DNSX_PYTHON3=ON ..

RUN cmake --build . --config Release --target package 



