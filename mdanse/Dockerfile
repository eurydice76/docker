FROM ubuntu:15.04

LABEL maintainer="pellegrini@ill.fr" 

# Allows to avoid any interactive post-install configuration 
RUN export DEBIAN_FRONTEND=noninteractive

# libcanberra-gtk-module --> remove wx warning
# wget                   --> for fetching ScientificPython and MMTK
# git                    --> for cloning MDANSE repo
# graphviz               --> for building MDANSE doc
# texlive-base           --> for building MDANSE doc
# texlive-latex-extra    --> for building MDANSE doc
# dvipng                 --> for building MDANSE doc
# g++                    --> for building the MDANSE extension that used C++ classes
# libnetcdf-dev          --> for building the scientific_netcdf extension
# cython                 --> for building ScientificPython/MMTK/MDANSE extensions
# python-dev             --> for building ScientificPython/MMTK/MDANSE extensions
# python-wxmpl           --> wxPython + matplotlib + wx backend
# python-netcdf          --> for building MMTK extension
# python-vtk             --> for visualizing MDANSE trajectories
# python-sphinx          --> for building MDANSE doc
# pyro                   --> for MDANSE parallelization
# kmod                   --> install insmode necessary when installing nvidia drivers
RUN apt-get update \
 && apt-get install -y --force-yes --no-install-recommends \
                       libcanberra-gtk-module              \	
                       wget                                \
                       git                                 \
                       graphviz                            \
                       texlive-base                        \
                       texlive-latex-extra                 \
                       dvipng                              \
                       g++                                 \
                       libnetcdf-dev                       \
                       cython                              \
                       python-dev                          \
                       python-wxmpl                        \
                       python-netcdf                       \
                       python-vtk                          \
                       python-sphinx                       \
                       pyro                                \
                       kmod                                \
&& apt-get autoclean                                       \
&& apt-get autoremove
#&& updatedb

WORKDIR /tmp

# Fetch the host machine nvidia driver
ADD NVIDIA-DRIVER.run NVIDIA-DRIVER.run

# INstall the driver
RUN sh /tmp/NVIDIA-DRIVER.run -a -N --ui=none --no-kernel-module

# Remove the nvidia driver
RUN rm /tmp/NVIDIA-DRIVER.run

# Fetch, build and install ScientificPython
RUN wget --no-check-certificate https://sourcesup.renater.fr/frs/download.php/file/4570/ScientificPython-2.9.4.tar.gz
RUN tar xvzf ScientificPython-2.9.4.tar.gz
WORKDIR /tmp/ScientificPython-2.9.4
RUN python setup.py build
RUN python setup.py install

# Remove ScientificPython sources
WORKDIR /tmp
RUN rm -rf ScientificPython-2.9.4*

# Fetch, build and install MMTK
RUN wget --no-check-certificate https://sourcesup.renater.fr/frs/download.php/file/4324/MMTK-2.7.9.tar.gz
RUN tar xvzf MMTK-2.7.9.tar.gz
WORKDIR /tmp/MMTK-2.7.9
RUN python setup.py build
RUN python setup.py install

# Remove MMTK sources
WORKDIR /tmp
RUN rm -rf MMTK-2.7.9*

# Clone the MDANSE repo
RUN GIT_SSL_NO_VERIFY=true git clone https://code.ill.fr/scientific-software/mdanse.git

# Build and install MDANSE
WORKDIR /tmp/mdanse
RUN python setup.py build
RUN python setup.py install

# Remove MDANSE sources
WORKDIR /tmp
RUN rm -rf mdanse

