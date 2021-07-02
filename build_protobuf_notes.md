# Build Protocol Buffers using Docker

Building the protobufs on my local Mac results in the below error. It is caused by not having the latest compiler.
However, I am not able to fix the issue locally. Therefore, to solve the problem, I use a Docker container.

```text
../../../../../go/pkg/mod/github.com/garystafford/protobuf@v0.0.0-20210628012658-a5a7cd0949b2/greeting/v2/greeting.pb.gw.go:39:2: cannot use msg (type *GreetingResponse) as type protoreflect.ProtoMessage in return argument:
	*GreetingResponse does not implement protoreflect.ProtoMessage (missing ProtoReflect method)
../../../../../go/pkg/mod/github.com/garystafford/protobuf@v0.0.0-20210628012658-a5a7cd0949b2/greeting/v2/greeting.pb.gw.go:48:2: cannot use msg (type *GreetingResponse) as type protoreflect.ProtoMessage in return argument:
	*GreetingResponse does not implement protoreflect.ProtoMessage (missing ProtoReflect method)`
```

## Builder Container

```shell
mkdir build-protobufs \
  && cd build-protobufs
docker run --rm -it -v "$PWD":/tmp golang:latest bash
```

## Build Protobufs

```shell
cd /tmp

go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest \
    && go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest \
    && go install google.golang.org/protobuf/cmd/protoc-gen-go@latest \
    && go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

export bufbuilder=v0.43.2
wget https://github.com/bufbuild/buf/releases/download/${bufbuilder}/buf-Linux-aarch64.tar.gz \
    && tar -xf buf-Linux-aarch64.tar.gz \
    && rm -rf buf-Linux-aarch64.tar.gz \
    && export PATH="/tmp/buf/bin:$PATH"

git clone https://github.com/garystafford/pb-greeting.git \
    && cd pb-greeting/

buf beta mod update

buf lint
buf ls-files

buf generate --path proto/greeting/v3 -v
```

Copy the resulting files into the `protobuf` project and commit to GitHub.

```shell
rm -rf pb-greeting
rm -rf protobuf
```
