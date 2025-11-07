# ---- Build Stage ----
FROM golang:1.22-alpine AS builder

RUN apk add --no-cache git build-base

WORKDIR /app

# Copy ONLY Go files (avoids copying .github/.git/etc)
COPY main.go .

# Build static binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app main.go

# ---- Final Stage ----
FROM alpine:3.19

WORKDIR /app

COPY --from=builder /app/app .

ENTRYPOINT ["./app"]
