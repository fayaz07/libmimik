build:
	mkdir -p build
	go build -buildmode=c-shared -o build/libmimik.so src/main.go
