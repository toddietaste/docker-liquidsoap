all: build

build:
	docker build -t mtneug/liquidsoap .
.PHONY: build

clean:
	docker rmi mtneug/liquidsoap
.PHONY: clean
