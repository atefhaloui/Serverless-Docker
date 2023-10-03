FROM python:3.12.0-slim-bookworm

ARG SERVERLESS_RELEASE
ARG NODE_MAJOR

LABEL maintainer="StanGirard <stan@primates.dev>"

## Install required packages
RUN apt update && \
    apt install -y curl unzip gnupg ca-certificates

## Install AWS Cli
RUN curl --silent --show-error --fail "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Install node.js and yarn
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
      | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" \
      > /etc/apt/sources.list.d/nodesource.list && \
    apt update && \
    apt install -y nodejs npm

# Install serverless cli and compose
RUN npm install -g serverless@${SERVERLESS_RELEASE} && \
    npm install -g @serverless/compose

COPY bin/startup.sh .

RUN "./startup.sh"
