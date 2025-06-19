# Makefile pentru gestionarea imaginii Jenkins - Punctiq

REPO=itcommunity/automation-svc
VERSION=1.0.0
GIT_SHA=$(shell git rev-parse --short HEAD)
LOCAL_TAG=$(REPO):localtest
PROD_TAG=$(REPO):prod
VERSION_TAG=$(REPO):$(VERSION)
SHA_TAG=$(REPO):sha-$(GIT_SHA)

.PHONY: build up down restart logs shell tag push clean

build:
	sudo docker build -t $(LOCAL_TAG) .

up:
	sudo docker compose up -d

down:
	sudo docker compose down

restart: down up

logs:
	sudo docker compose logs -f

shell:
	sudo docker exec -it pctq-prod-hz-automation /bin/bash

tag:
	sudo docker tag $(LOCAL_TAG) $(VERSION_TAG)
	sudo docker tag $(LOCAL_TAG) $(PROD_TAG)
	sudo docker tag $(LOCAL_TAG) $(SHA_TAG)

push:
	sudo docker push $(VERSION_TAG)
	sudo docker push $(PROD_TAG)
	sudo docker push $(SHA_TAG)

clean:
	sudo docker rmi -f $(LOCAL_TAG) $(VERSION_TAG) $(PROD_TAG) $(SHA_TAG) || true
