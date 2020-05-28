FROM docker:18.09.9

RUN apk add --update \
  curl \
  && rm -rf /var/cache/apk/*

RUN wget -O kubectl https://storage.googleapis.com/kubernetes-release/release/v1.16.9/bin/linux/amd64/kubectl \
  && chmod +x kubectl \
  && wget -O kompose https://github.com/kubernetes/kompose/releases/download/v1.21.0/kompose-linux-amd64 \
  && chmod +x kompose \
  && mv kubectl kompose /usr/local/bin/

RUN curl -L https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst-`uname -s`-`uname -m` -o envsubst \
  && chmod +x envsubst \
  && mv envsubst /usr/local/bin/