#
# Makefile for vagabond Vagrant image
#

RECIPE  := build.json
NAME    := vagabond
BOX     := jhunt/$(NAME)
VERSION := $(shell ./version.sh)

default: test

test:
	@cat $(RECIPE) | jq . >/dev/null
	@VERSION=$(VERSION) TOKEN=$(TOKEN) packer validate $(RECIPE)

build:
	VERSION=$(VERSION) TOKEN=$(TOKEN) packer build $(RECIPE)

release:
	TOKEN=$(TOKEN) packer push -name $(BOX) $(RECIPE)
	git tag v$(VERSION)

clean:
	rm -rf output-*/

distclean: clean
	rm -rf packer_cache/

import:
	vagrant box remove --force $(NAME) || true
	vagrant box add --name $(NAME) boxen/$(NAME).box
