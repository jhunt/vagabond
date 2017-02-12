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
	@packer validate $(RECIPE)

# requires Enterprise something-something; not worth it.
#push:
#	packer push -name $(BOX) $(RECIPE)

build:
	jq '. + {"post-processors": [[.["post-processors"][][] | select(.type!="atlas")]]}' $(RECIPE) | \
		VERSION=$(VERSION) packer build -

# requires Enterprise something-something; not worth it.
#release:
#	packer push -name $(BOX) $(RECIPE)
#	git tag v$(VERSION)

clean:
	rm -rf output-*/
distclean: clean
	rm -rf packer_cache/

import:
	vagrant box remove --force $(NAME) || true
	vagrant box add --name $(NAME) boxen/$(NAME).box
