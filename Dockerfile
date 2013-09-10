FROM ubuntu

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y inotify-tools nginx openssh-server
RUN useradd ruby -p ruby
ADD ./ /home/ruby/app/
EXPOSE 80
