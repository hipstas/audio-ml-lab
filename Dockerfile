# Audio ML Notebook

FROM ubuntu:14.04

MAINTAINER Steve McLaughlin <stephen.mclaughlin@utexas.edu>

EXPOSE 8888
ENV PYTHONWARNINGS="ignore:a true SSLContext object"

# Install dependencies
RUN apt-get update && apt-get install -y \
 wget \
 curl \
 git \
 swig \
 libgtk-3-dev \
 software-properties-common \
 build-essential \
 zip \
 unzip \
 sox \
 libsox-fmt-mp3 \
 libimage-exiftool-perl \
 python2.7 \
 python-pip \
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
 python-numpy-dev \
 python-numpy \
 python-yaml \
 cmake \
 libjack-dev \
 libasound2-dev \
 libsndfile1-dev \
 praat \
 && python -m pip install -U pip \
 && pip install -U \
 setuptools \
 pyOpenSSL \
 ndg-httpsclient \
 pyasn1 \
 requests \
 unicodecsv \
 youtube-dl \
 six \
 pydub \
 numpy \
 jupyter \
 pandas \
 matplotlib \
 scipy \
 sklearn \
 librosa \
 aubio \
 moviepy \
 pyAudioAnalysis \
 pocketsphinx \
 speechrecognition \
 tornado \
 pathlib \
 tflearn \
 scikits.talkbox \
 scikits.audiolab \
 git+git://github.com/hipstas/audio-tagging-toolkit.git \
 && git clone https://github.com/MTG/essentia.git \
 && cd essentia \
 && ./waf configure --mode=release --build-static --with-python --with-cpptests --with-examples --with-vamp \
 && ./waf \
 && ./waf install \
 && cd ../ \
 && rm -rf essentia

# Omitting Marsyas for now:
#
# && git clone https://github.com/marsyas/marsyas.git \
# && cd marsyas \
# && mkdir build \
# &&  cd build \
# && cmake .. \
# && make \
# && make install \
# && cd /home/sharedfolder \
# && rm -rf marsyas

# Install FFmpeg with mp3 support
RUN add-apt-repository -y ppa:mc3man/trusty-media \
 && apt-get update -y \
 && apt-get install -y ffmpeg gstreamer0.10-ffmpeg

# Configure container startup
ENV SHELL /bin/bash
WORKDIR /home/sharedfolder
CMD cd /home/sharedfolder/ && wget -nc https://github.com/hipstas/audio-tagging-toolkit/blob/master/scripts/Classify_and_Play.zip?raw=true -O Classify_and_Play.zip
CMD jupyter notebook --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.iopub_data_rate_limit=1.0e10 --NotebookApp.token=''

# Launch container and open notebook like so:
# docker pull stevemclaugh/audio-ml-notebook
# docker run -it --name audio_ml_container -p 8888:8888 -v ~/Desktop/sharedfolder:/home/sharedfolder stevemclaugh/audio-ml-notebook
