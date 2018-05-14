# Audio ML Notebook
FROM ubuntu:16.04

MAINTAINER Steve McLaughlin <stephen.mclaughlin@utexas.edu>

EXPOSE 8887
ENV PYTHONWARNINGS="ignore:a true SSLContext object"

# Install dependencies
RUN apt-get update && apt-get install -y \
 wget \
 curl \
 git \
 swig3.0 \
 libgtk-3-dev \
 software-properties-common \
 build-essential \
 zip \
 unzip \
 sox \
 libsox-fmt-mp3 \
 libimage-exiftool-perl \
 python2.7 \
 python-dev \
 libffi-dev \
 libssl-dev \
 ipython \
 ipython-notebook \
 python-matplotlib \
 libfreetype6-dev \
 libxft-dev \
 libblas-dev \
 liblapack-dev \
 libatlas-base-dev \
 gfortran \
 libpulse-dev \
 aubio-tools \
 libaubio-dev \
 libaubio-doc \
 libyaml-dev \
 libfftw3-dev \
 libavcodec-dev \
 libavformat-dev \
 libavutil-dev \
 libavresample-dev \
 libsamplerate0-dev \
 libtag1-dev \
 cmake \
 libjack-dev \
 libasound2-dev \
 libsndfile1-dev \
 praat

## Installing Python and the SciPy stack
RUN apt-get update && apt-get install -y \
python-dev \
python2.7 \
python3 \
python-pip \
python-setuptools \
python-numpy-dev \
python-numpy \
python-yaml \
ipython \
ipython-notebook \
python-numpy-dev \
python-matplotlib

## Installing Python packages
COPY ./requirements.txt /var/local/
RUN apt-get update \
&& add-apt-repository -y ppa:jonathonf/python-2.7 \
&& apt-get update \
&& apt-get install -y python2.7 \
&& apt-get install -y python-pip \
&& cd /usr/local/bin/ && wget -N https://raw.githubusercontent.com/hipstas/audio-ml-lab/master/pip \
&& pip install --upgrade pip \
&& pip2 install --upgrade pip \
&& pip2 install bleach==1.5.0 \
&& pip2 install tqdm==4.11.2 \
&& pip2 install decorator==4.0.11 \
&& pip2 install --ignore-installed -qr /var/local/requirements.txt \
&& apt-get install -y libjpeg-dev \
&& apt-get install -y python3-pip \
&& cd /usr/local/bin/ && wget -N https://raw.githubusercontent.com/hipstas/audio-ml-lab/master/pip3 \
&& pip3 install --upgrade pip \
&& pip3 install --upgrade setuptools \
&& pip3 install --upgrade h5py \
&& pip3 install --ignore-installed -qr /var/local/requirements.txt \
&& pip install git+git://github.com/hipstas/audio-tagging-toolkit \
&& pip3 install git+git://github.com/hipstas/audio-tagging-toolkit
#RUN jupyter serverextension enable --py jupyterlab --sys-prefix

## Installing Python2 and Python3 kernels for Jupyter
RUN python3 -m pip install jupyterhub notebook ipykernel \
&& python3 -m ipykernel install \
&& python2 -m pip install ipykernel \
&& python2 -m ipykernel install

## Not Installing Essentia
#RUN git clone https://github.com/MTG/essentia.git \
#&& cd essentia \
#&& ./waf configure --mode=release --build-static --with-python --with-cpptests --with-examples --with-vamp \
#&& ./waf \
#&& ./waf install \
#&& cd ../ \
#&& rm -rf essentia

## Installing FFmpeg
RUN add-apt-repository ppa:jonathonf/ffmpeg-3 \
&& apt-get -y update \
&& apt-get install -y ffmpeg libav-tools x264 x265

# Omitting Marsyas for now:
# git clone https://github.com/marsyas/marsyas.git \
# && cd marsyas \
# && mkdir build \
# &&  cd build \
# && cmake .. \
# && make \
# && make install \
# && cd /sharedfolder \
# && rm -rf marsyas

## Setting UTF-8 as default encoding format for terminal
RUN apt-get install -y language-pack-en
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Configure container startup
ENV SHELL /bin/bash
WORKDIR /sharedfolder
#CMD cd /sharedfolder/ && wget -nc https://github.com/hipstas/audio-tagging-toolkit/blob/master/scripts/Classify_and_Play.zip?raw=true -O Classify_and_Play.zip
CMD jupyter notebook --ip 0.0.0.0 --port 8887 --no-browser --allow-root --NotebookApp.iopub_data_rate_limit=1.0e10 --NotebookApp.token=''

# Launch container and open notebook like so:
# docker pull hipstas/audio-ml-lab
# docker run -it --name audio_ml_lab -p 8887:8887 -v ~/Desktop/sharedfolder:/sharedfolder hipstas/audio-ml-lab
