REPO := registry.gitlab.com/ayufan/kubernetes-deploy:latest

build:
		docker build -q -t $(REPO) .

build_and_push: build
		docker push $(REPO)

build_test: build
		source .dev_env && cd examples/rails-app/ && ../../build

deploy_test:
		source .dev_env && cd examples/rails-app/ && ../../deploy

build_and_enter: build
		docker run --privileged -it --rm -v $(shell pwd):/app -w /app $(REPO) /bin/bash --login

build_and_test: build
		docker run --privileged -it --rm -v $(shell pwd):/app -w /app $(REPO) /bin/bash --login -c 'source .dev_env && ./deploy'

.PHONY: build build_and_push build_test build_and_enter deploy_test build_and_test
