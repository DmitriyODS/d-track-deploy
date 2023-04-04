.PHONY: all release build back-build front-build back-push front-push


IMAGE_REPO=osipovskijdima
IMAGE_D_TRACK_FRONT=$(IMAGE_REPO)/d-track-front:$(shell cd d-track-front && git describe --abbrev=0 --tags)
IMAGE_D_TRACK_BACK=$(IMAGE_REPO)/d-track-back:$(shell cd d-track-back && git describe --abbrev=0 --tags)


all: release

release: back-build front-build back-push front-push

build: back-build front-build

back-build:
	@echo "start making image" $(IMAGE_D_TRACK_BACK)
	docker build -f ./service.Dockerfile -t $(IMAGE_D_TRACK_BACK) .
	@echo "finish making image" $(IMAGE_D_TRACK_BACK)

front-build:
	@echo "start making image" $(IMAGE_D_TRACK_FRONT)
	docker build --build-arg base_url=back:8080 -f ./client.Dockerfile -t $(IMAGE_D_TRACK_FRONT) .
	@echo "finish making image" $(IMAGE_D_TRACK_FRONT)

back-push:
	@docker push $(IMAGE_D_TRACK_BACK)

front-push:
	@docker push $(IMAGE_D_TRACK_FRONT)
