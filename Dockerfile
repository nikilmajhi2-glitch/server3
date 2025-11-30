FROM golang:1.21-alpine AS builder

RUN apk add --no-cache gcc g++ make git

WORKDIR /app

COPY src/go.mod src/go.sum ./src/
WORKDIR /app/src
RUN go mod download

COPY src/. .

RUN go build -o /app/main .

FROM alpine

WORKDIR /root/

COPY --from=builder /app/main .

EXPOSE 3000

CMD ["./main"]