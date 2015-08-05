FROM ubuntu:14.04
MAINTAINER Andres Riancho <andres.riancho@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y supervisor joe
RUN apt-get install -y libssl-dev libxml2-dev libxslt1-dev libmemcached-dev
RUN apt-get install -y git-core python-pip build-essential python-dev python-software-properties

RUN mkdir -p /var/log/supervisor
RUN useradd ubuntu -d /home/ubuntu

# Django moth configuration
WORKDIR /home/ubuntu/

RUN git clone https://github.com/andresriancho/django-moth.git
WORKDIR /home/ubuntu/django-moth
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

ADD docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN rm -rf /var/lib/apt/lists/*

EXPOSE 8000
CMD ["/usr/bin/supervisord"]
