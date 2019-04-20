# Go-based Microservice for Istio Observability Demo

Protocol Buffers for set of Go-based, RESTful microservices, which make up this reference distributed system platform, designed to generate service-to-service, service-to-database (MongoDB), and service-to-queue-to-service (RabbitMQ) IPC (inter-process communication).

## Commands

```bash
# reference: https://github.com/grpc-ecosystem/grpc-gateway

# Required packages
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
go get -u github.com/golang/protobuf/protoc-gen-go

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
  ```
  
  ## Output Sample

```json
{
  "greeting": [
    {
        "id": "9f12e095-989f-49aa-80f7-05f27a1ae2ef",
        "service": "Service-D",
        "message": "Shalom, from Service-D!",
        "created": "2019-03-17T16:10:16.197706983Z"
    },
    {
        "id": "a2ed6cac-88bc-42b5-9d94-7b64a655ead9",
        "service": "Service-G",
        "message": "Ahlan, from Service-G!",
        "created": "2019-03-17T16:10:16.229348021Z"
    },
    {
        "id": "d5384ee3-1d43-460a-abc8-142e5d5f5b8e",
        "service": "Service-H",
        "message": "Ciao, from Service-H!",
        "created": "2019-03-17T16:10:16.293059651Z"
    },
    {
        "id": "953d654d-5c32-4d5d-9ce1-e158dee3701b",
        "service": "Service-E",
        "message": "Bonjour, de Service-E!",
        "created": "2019-03-17T16:10:16.414109276Z"
    },
    {
        "id": "98a73e02-9c4a-443a-a4c9-1f0216d5c099",
        "service": "Service-B",
        "message": "Namaste, from Service-B!",
        "created": "2019-03-17T16:10:16.415805403Z"
    },
    {
        "id": "d5cd62d4-fe79-4b6b-81a9-80d59f3d42c3",
        "service": "Service-C",
        "message": "Konnichiwa, from Service-C!",
        "created": "2019-03-17T16:10:16.420415356Z"
    },
    {
        "id": "844ea9c7-b340-4956-9c8b-f28ae42d0f4a",
        "service": "Service-A",
        "message": "Hello, from Service-A!",
        "created": "2019-03-17T16:10:16.4982543Z"
    }
  ]
}
```
