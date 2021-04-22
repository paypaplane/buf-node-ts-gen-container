FROM linuxbrew/brew
SHELL ["/bin/bash", "-c"]
WORKDIR /root
RUN brew install node
RUN brew install protobuf
RUN npm update
RUN npm install -g grpc-tools
RUN npm install -g ts-proto
RUN brew tap bufbuild/buf
RUN brew install buf
# Installing go and dependencies
RUN curl -o /tmp/go1.16.2.linux-amd64.tar.gz https://dl.google.com/go/go1.16.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /tmp/go1.16.2.linux-amd64.tar.gz
RUN rm /tmp/go1.16.2.linux-amd64.tar.gz
RUN echo 'PATH=/root/go/bin:/usr/local/go/bin:$PATH' >>~/.profile
RUN go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest
RUN go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest