install:
	go mod download

build:
	mkdir -p build
	go build -o build/libmimik.so src/main.go

clean_proto:
	rm -rf engine/types/*.pb.go

gen_proto: clean_proto
	protoc --go_out=./ --go_opt=paths=source_relative engine/types/**/*.proto
