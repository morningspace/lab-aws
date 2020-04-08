FROM ubuntu:18.04

# install build tools, e.g. make, gcc, python
RUN set -ex; \
  apt-get update; \
  apt-get -y install curl python3 python3-distutils groff vim sudo

RUN adduser --gecos '' --disabled-password coder && \
	echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

USER coder
ENV PATH /home/coder/.local/bin:$PATH

# install aws-cli
RUN curl https://bootstrap.pypa.io/get-pip.py -o $HOME/get-pip.py; \
  python3 $HOME/get-pip.py --user; \
  $HOME/.local/bin/pip3 install awscli --upgrade --user; \
  echo "complete -C ~/.local/bin/aws_completer aws" >> ~/.bashrc; \
  rm $HOME/get-pip.py; \
# kubectl
  curl -o $HOME/.local/bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl; \
  chmod +x $HOME/.local/bin/kubectl

WORKDIR /home/coder
