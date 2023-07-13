#!/usr/bin/make -f

clean:
	@rm -rf ./build


build:
	@echo Building cosmos ...
	@go build -o ./build/exampled example/cmd/exampled