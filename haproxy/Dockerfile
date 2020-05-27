FROM haproxy:2.0.14

RUN useradd haproxy
# RUN apt install curl

ENV BASE64_AUTH=YmFzaWNhZG1pbjpiYXNpY3Bhc3N3b3Jk

COPY ./haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

EXPOSE 80