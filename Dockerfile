# Multi-stage build for efficiency

# Stage 1: Build Go WebAssembly
FROM golang:1.24-alpine AS go-builder

# Set working directory for Go build
WORKDIR /app/go

# Copy Go module files
COPY go/go.mod go/go.sum ./

# Download Go dependencies
RUN go mod download

# Copy Go source code
COPY go/ ./

# Build WebAssembly binary
RUN GOOS=js GOARCH=wasm go build -o main.wasm main.go

# Stage 2: Build React frontend
FROM node:22-alpine AS node-builder

# Set working directory for Node build
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies (including dev dependencies for build)
RUN npm ci

# Copy source code
COPY . .

# Copy the built WASM file from the Go builder stage
COPY --from=go-builder /app/go/main.wasm ./public/main.wasm

# Build the React application
RUN npm run build

# Stage 3: Production server
FROM nginx:alpine

# Copy the built React app to nginx
COPY --from=node-builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
