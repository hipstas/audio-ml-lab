# Audio ML Lab

Enter the following three commands in the terminal to kill an existing Audio ML Lab container (if applicable) and launch a new one.

```
docker rm -f audio_ml_lab
docker pull hipstas/audio-ml-lab
docker run -it --name audio_ml_lab -d -p 8888:8888 -v ~/Desktop/sharedfolder:/home/sharedfolder hipstas/audio-ml-lab

```

Enter `http://localhost:8888` in your browser's URL bar to launch Jupyter.
