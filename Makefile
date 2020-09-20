NAME=bl4ck5un/sgx-docker
TAG=2.11

build_and_push:
	docker build . -t ${NAME}:${TAG}
	docker push ${NAME}:${TAG}
