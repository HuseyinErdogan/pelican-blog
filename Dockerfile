FROM python:3.10.13 as builder

RUN apt update && apt upgrade -y && \
	pip install pelican markdown flask
RUN mkdir -p /srv/pelican/content

RUN ls
#COPY ./content /srv/pelican/content
COPY pelicanconf.py /srv/pelican/
COPY publishconf.py /srv/pelican/
COPY ./theme-basic /srv/pelican/theme-basic
COPY Makefile /srv/pelican/

WORKDIR /srv/pelican

RUN make html

FROM nginx as deploy
MAINTAINER HuseyinErdogan

RUN apt-get update
RUN apt-get -y upgrade

COPY --from=builder /srv/pelican/output /var/www/html

WORKDIR /var/www/html

RUN rm /etc/nginx/conf.d/default.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf