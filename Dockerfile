FROM linuxbrew/brew
RUN brew install node
RUN brew install protobuf
RUN npm update
RUN npm install -g grpc-tools
RUN npm install -g grpc_tools_node_protoc_ts
RUN brew tap bufbuild/buf
RUN brew install buf