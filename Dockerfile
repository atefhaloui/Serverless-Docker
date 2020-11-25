FROM python:3.7.9-slim-buster

ARG RELEASE

LABEL maintainer="StanGirard <stan@primates.dev>"

## Install AWS Cli
RUN apt-get clean & apt-get update
RUN apt-get install curl unzip -y
RUN curl --silent --show-error --fail "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install



# Install node.js and yarn
RUN rm -rf /var/lib/apt/lists/*
RUN curl -sL https://deb.nodesource.com/setup_12.x > node_install.sh
RUN chmod +x ./node_install.sh
RUN ./node_install.sh
RUN curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils nodejs yarn groff rsync




# Install serverless cli
RUN yarn global add serverless@${RELEASE}

COPY bin/startup.sh .
RUN "./startup.sh"


