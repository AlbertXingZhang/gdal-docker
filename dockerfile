FROM microsoft/aspnetcore

ADD . /tmp

RUN /tmp/build.sh
