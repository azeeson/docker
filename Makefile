
build: build_java_ubuntu

build_java_alpine:
	docker build --no-cache --platform linux/amd64 -t java8_alpine:latest java.alpine -f java.alpine/Dockerfile

build_java_ubuntu:
	docker build --no-cache --platform linux/amd64 -t java8_ubuntu:latest java.ubuntu -f java.ubuntu/Dockerfile

.PHONY: build