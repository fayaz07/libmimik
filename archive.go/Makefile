install:
	go mod download

# Build regular binary
build:
	mkdir -p build
	go build -o build/libmimik src/*.go

# Build for macOS (regular binary)
build-macos:
	mkdir -p build
	go build -buildmode=c-archive -o build/libmimik.a src/*.go

# Build shared library (without CGO)
build-shared:
	mkdir -p build
	go build -buildmode=plugin -o build/libmimik.so src/*.go

# Build static archive (without CGO)
build-static:
	mkdir -p build
	CGO_ENABLED=0 go build -o build/libmimik.a ./src/*.go

# Build C-compatible archive with header file (requires CGO)
build-c-archive:
	mkdir -p build
	CGO_ENABLED=1 go build -buildmode=c-archive -o build/libmimik.a ./src/*.go

# Alternative: Build as plugin (what was working before)
build-plugin:
	mkdir -p build
	CGO_ENABLED=0 go build -buildmode=plugin -o build/libmimik.a ./src

clean_proto:
	rm -rf engine/types/*.pb.go

gen_proto: clean_proto
	protoc --go_out=./ --go_opt=paths=source_relative engine/types/**/*.proto

clean:
	rm -rf build/

gen_proto-swift:
	mkdir -p generated/swift
	protoc --swift_out=./generated/swift \
		--proto_path=engine/types/core engine/types/core/*.proto
