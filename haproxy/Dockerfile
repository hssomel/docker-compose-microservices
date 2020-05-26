FROM haproxy:2.0.14

RUN useradd haproxy
# RUN apt install curl

COPY ./haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

EXPOSE 80