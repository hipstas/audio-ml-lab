# Audio ML Lab

Enter the following three commands in the terminal to kill an existing Audio ML Lab container (if applicable), then download and run the latest version of this Docker container.

```
docker rm -f audio_ml_lab
docker pull hipstas/audio-ml-lab
docker run -it --name audio_ml_lab -d -p 8888:8888 -v ~/Desktop/sharedfolder:/home/sharedfolder hipstas/audio-ml-lab
```

When the commands above finished running, point your browser to `http://localhost:8888` in to launch the Jupyter interface.
