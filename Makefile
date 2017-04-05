
IMAGE ?= euskadi31/sphinx
VERSION ?= 2.2.11

docker:
	@sudo docker build --rm -t $(IMAGE) .

run: docker
	@sudo docker run --rm $(IMAGE)

publish: docker
	@sudo docker tag $(IMAGE) $(IMAGE):latest
	@sudo docker tag $(IMAGE) $(IMAGE):$(VERSION)
	@sudo docker push $(IMAGE)
