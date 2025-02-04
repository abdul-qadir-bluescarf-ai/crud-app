# Use the official Golang image as the base image for building the application
FROM golang:1.23.4-alpine AS builder

# Set the working directory inside the build container
WORKDIR /app

# Copy the Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the application code
COPY crud.go ./

# Build the Go application
RUN go build -o crud-app

# Use a minimal base image for the final container
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled binary from the build container
COPY --from=builder /app/crud-app .

# Expose the port the application will run on
EXPOSE 8080

# Command to run the application
CMD ["./crud-app"]


# # Use the official Golang image as the base image
# FROM golang:1.23.4-alpine

# # Set the working directory inside the container
# WORKDIR /dir

# # Copy the Go module files and download dependencies
# COPY go.mod ./
# RUN go mod download

# # Copy the rest of the application code
# COPY crud.go .

# # Build the Go application
# RUN go build -o crud-app

# # Expose the port the application will run on
# EXPOSE 8080

# # Command to run the application
# CMD ["./crud-app"]
