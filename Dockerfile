FROM python:3.10.13

RUN apt update && apt upgrade -y && \
	pip install pelican markdown flask
RUN mkdir -p /srv/pelican/content

COPY ./content /srv/pelican/content
COPY pelicanconf.py /srv/pelican/
COPY publishconf.py /srv/pelican/
COPY ./theme-basic /srv/pelican/theme-basic
COPY Makefile /srv/pelican/

WORKDIR /srv/pelican

CMD [ "make", "devserver" ]