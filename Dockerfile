FROM fedora:37

COPY . /opt/deezer
RUN dnf install -y --setopt=install_weak_deps=False ffmpeg-free
RUN dnf install -y yt-dlp
RUN dnf install -y python3-gunicorn 
RUN dnf install -y python3-pip
RUN python3 -m pip install -r /opt/deezer/requirements.txt

RUN cp /opt/deezer/app/settings.ini.example /opt/deezer/app/settings.ini
RUN sed -i 's,/tmp/deezer-downloader,/mnt/deezer-downloader,' /opt/deezer/app/settings.ini
RUN mkdir -p /mnt/deezer-downloader

EXPOSE 5000
WORKDIR /opt/deezer/app
CMD python3 -m gunicorn --bind 0.0.0.0:5000 app:app
