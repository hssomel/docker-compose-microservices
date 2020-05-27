FROM docker:18.09.9

RUN wget https://storage.googleapis.com/kubernetes-release/release/v1.16.9/bin/linux/amd64/kubectl \
  && chmod +x kubectl \
  && mv kubectl /usr/local/bin/kubectl \
  && wget https://github.com/kubernetes/kompose/releases/download/v1.21.0/kompose-linux-amd64 \
  && chmod +x kompose-linux-amd64 \
  && mv kompose-linux-amd64 /usr/local/bin/kompose \
  && wget https://github.com/docker/compose/releases/download/1.25.5/docker-compose-Linux-x86_64 \
  && chmod +x docker-compose-Linux-x86_64 \
  && mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
