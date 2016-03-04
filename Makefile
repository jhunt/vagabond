#
# Makefile for vagabond Vagrant image
#

RECIPE := build.json
NAME   := vagabond
BOX    := jhunt/$(NAME)

default: test

test:
	@cat $(RECIPE) | jq . >/dev/null
	@packer validate $(RECIPE)

push:
	packer push -name $(BOX) $(RECIPE)

build:
	jq '. + {"post-processors": [[.["post-processors"][][] | select(.type!="atlas")]]}' $(RECIPE) | packer build -

clean:
	rm -rf output-*/

import:
	vagrant box remove --force $(NAME) || true
	vagrant box add --name $(NAME) boxen/$(NAME).box
