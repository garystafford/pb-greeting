// +build tools

package tools

// v1.16.0 grpc-gateway
// https://github.com/grpc-ecosystem/grpc-gateway/tree/094a6fe78b3ca888297d090185cdf30f0e42e157
//import (
//	_ "github.com/golang/protobuf/protoc-gen-go"
//	_ "github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway"
//	_ "github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger"
//)

// v2 grpc-gateway
//https://github.com/grpc-ecosystem/grpc-gateway
import (
	_ "github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway"
	_ "github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2"
	_ "google.golang.org/grpc/cmd/protoc-gen-go-grpc"
	_ "google.golang.org/protobuf/cmd/protoc-gen-go"
)