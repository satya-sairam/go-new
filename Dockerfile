# ---- Build Stage ----
FROM golang:1.22-alpine AS builder

RUN apk add --no-cache git build-base

WORKDIR /app

# Copy source code (no Go modules used)
COPY . .

# Build static binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app .

# ---- Final Stage ----
FROM alpine:3.19

WORKDIR /app

COPY --from=builder /app/app .

ENTRYPOINT ["./app"]
