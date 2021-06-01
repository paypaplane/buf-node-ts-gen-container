FROM debian:10-slim
SHELL ["/bin/bash", "-c"]
WORKDIR /root
RUN apt update && apt install -y unzip curl make git 

# Install node
RUN curl -fsSL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

# Install protoc
RUN curl -L https://github.com/protocolbuffers/protobuf/releases/download/v3.15.8/protoc-3.15.8-linux-x86_64.zip --output /tmp/protoc.zip
RUN unzip /tmp/protoc.zip -d /usr/local

# Install node generation deps
RUN npm update
RUN npm install -g grpc-tools ts-proto typescript yarn --unsafe-perm

# Install Buf
RUN curl -L https://github.com/bufbuild/buf/releases/download/v0.41.0/buf-Linux-x86_64.tar.gz --output /tmp/buf.tar.gz
RUN tar -xzf /tmp/buf.tar.gz -C /usr/local --strip-components=1

# Installing go and dependencies
RUN curl https://dl.google.com/go/go1.16.2.linux-amd64.tar.gz --output /tmp/go.tar.gz
RUN tar -C /usr/local -xzf /tmp/go.tar.gz
ENV PATH="/root/go/bin:/usr/local/go/bin:${PATH}"
RUN go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest
RUN go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# Install git
RUN apt update
RUN apt install -y git

# ===== Cleanup =====
RUN apt clean
RUN rm /tmp/protoc.zip
RUN rm /tmp/buf.tar.gz
RUN rm /tmp/go.tar.gz
RUN apt remove -y unzip curl
RUN apt autoremove -y


