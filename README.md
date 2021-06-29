# Protobuf Files for Istio Observability Demo

Protocol Buffers (Protobuf) files for reference application platform, used in my Istio observability demo blog posts.

## Commands

```shell
go mod tidy

buf beta mod update
buf lint
buf ls-files
```

Generates (4) files: go, grpc, grpc gateway, and swagger

```shell
exort GOBIN=/Users/garystafford/go/bin
buf generate -v

# alternately
buf generate --path proto/greeting/v2 -v

buf protoc -I . \
  --openapiv2_out=../protobuf --openapiv2_opt=logtostderr=true \
  --go_out=../protobuf --go_opt=paths=source_relative \
  --go-grpc_out=../protobuf --go-grpc_opt=paths=source_relative \
  --grpc-gateway_out=../protobuf --grpc-gateway_opt=paths=source_relative,generate_unbound_methods=true \
  proto/greeting/v2/greeting.proto

buf protoc -I . \
  --go_out=../protobuf --go_opt=paths=source_relative \
  proto/greeting/v2/greeting.proto
  
python3 -m grpc_tools.protoc -I . \
  --python_out=../protobuf \
  --grpc_python_out=../protobuf \
  --grpc-gateway_out=../protobuf --grpc-gateway_opt=paths=source_relative,generate_unbound_methods=true \
  proto/greeting/v2/greeting.proto

```

Use Docker to view Swagger doc at <http://localhost:8080/>.

```shell
docker run -p 8080:8080 -d --name swagger-ui \
  -e SWAGGER_JSON=/tmp/greeting/v2/greeting.swagger.json \
  -v ~/Documents/projects/protobuf:/tmp swaggerapi/swagger-ui
```

## Sample Output an Array of Greeting

```json
{
  "greeting": [
    {
      "id": "a9afab6a-3e2a-41a6-aec7-7257d2904076",
      "service": "Service D",
      "message": "Shalom (שָׁלוֹם), from Service D!",
      "created": "2021-06-04T14:28:32.695151047Z",
      "hostname": "service-d-565c775894-vdsjx"
    },
    {
      "id": "6d4cc38a-b069-482c-ace5-65f0c2d82713",
      "service": "Service G",
      "message": "Ahlan (أهلا), from Service G!",
      "created": "2021-06-04T14:28:32.814550521Z",
      "hostname": "service-g-5b846ff479-znpcb"
    },
    {
      "id": "988757e3-29d2-4f53-87bf-e4ff6fbbb105",
      "service": "Service H",
      "message": "Nǐ hǎo (你好), from Service H!",
      "created": "2021-06-04T14:28:32.947406463Z",
      "hostname": "service-h-76cb7c8d66-lkr26"
    },
    {
      "id": "966b0bfa-0b63-4e21-96a1-22a76e78f9cd",
      "service": "Service E",
      "message": "Bonjour, from Service E!",
      "created": "2021-06-04T14:28:33.007881464Z",
      "hostname": "service-e-594d4754fc-pr7tc"
    },
    {
      "id": "c612a228-704f-4562-90c5-33357b12ff8d",
      "service": "Service B",
      "message": "Namasté (नमस्ते), from Service B!",
      "created": "2021-06-04T14:28:33.015985983Z",
      "hostname": "service-b-697b78cf54-4lk8s"
    },
    {
      "id": "b621bd8a-02ee-4f9b-ac1a-7d91ddad85f5",
      "service": "Service C",
      "message": "Konnichiwa (こんにちは), from Service C!",
      "created": "2021-06-04T14:28:33.042001406Z",
      "hostname": "service-c-7fd4dd5947-5wcgs"
    },
    {
      "id": "52eac1fa-4d0c-42b4-984b-b65e70afd98a",
      "service": "Service A",
      "message": "Hello, from Service A!",
      "created": "2021-06-04T14:28:33.093380628Z",
      "hostname": "service-a-6f776d798f-5l5dz"
    }
  ]
}
```
