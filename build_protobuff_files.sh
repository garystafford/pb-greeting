#!/bin/bash
#
# author: Gary A. Stafford
# site: https://programmaticponderings.com
# license: MIT License
# purpose: Build protobuf files

# https://github.com/grpc-ecosystem/grpc-gateway

# Required packages
#go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
#go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
#go get -u github.com/golang/protobuf/protoc-gen-go

# Generate gRPC stub (.pb.go)
protoc -I /usr/local/include -I. \
  -I ${GOPATH}/src \
  -I ${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --go_out=plugins=grpc:. \
  greeting.proto

# Generate reverse-proxy (.pb.gw.go)
protoc -I /usr/local/include -I. \
  -I ${GOPATH}/src \
  -I ${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --grpc-gateway_out=logtostderr=true:. \
  greeting.proto

# Generate swagger definitions (.swagger.json)
protoc -I /usr/local/include -I. \
  -I ${GOPATH}/src \
  -I ${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --swagger_out=logtostderr=true:. \
  greeting.proto

# View Swagger doc
docker run -p 8080:8080 -d --name swagger-ui \
  -e SWAGGER_JSON=/tmp/greeting.swagger.json \
  -v /Users/garystafford/go-workspace/src/pb-greeting:/tmp swaggerapi/swagger-ui