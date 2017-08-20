# Audio ML Notebook

FROM ubuntu:14.04

MAINTAINER Steve McLaughlin <stephen.mclaughlin@utexas.edu>

EXPOSE 8887
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
 plotly \
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
 keras \
 h5py \
 tensorflow>=1.0.0 \
 google-api-python-client \
 Pillow \
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

# Install FFmpeg with mp3 support
RUN add-apt-repository ppa:jonathonf/ffmpeg-3 \
&& apt -y update \
&& apt install -y ffmpeg libav-tools x264 x265

# Omitting Marsyas for now:
#
# && git clone https://github.com/marsyas/marsyas.git \
# && cd marsyas \
# && mkdir build \
# &&  cd build \
# && cmake .. \
# && make \
# && make install \
# && cd /sharedfolder \
# && rm -rf marsyas


# Configure container startup
ENV SHELL /bin/bash
WORKDIR /sharedfolder
#CMD cd /sharedfolder/ && wget -nc https://github.com/hipstas/audio-tagging-toolkit/blob/master/scripts/Classify_and_Play.zip?raw=true -O Classify_and_Play.zip
CMD jupyter notebook --ip 0.0.0.0 --port 8887 --no-browser --allow-root --NotebookApp.iopub_data_rate_limit=1.0e10 --NotebookApp.token=''

# Launch container and open notebook like so:
# docker pull hipstas/audio-ml-lab
# docker run -it --name audio_ml_lab -p 8887:8887 -v ~/Desktop/sharedfolder:/sharedfolder hipstas/audio-ml-lab
