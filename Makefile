install:
	go mod download

build:
	mkdir -p build
	go build -o build/libmimik.so src/main.go
