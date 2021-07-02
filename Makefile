# Include local env vars
ifneq ("$(wildcard .env)","")
    include .env
	export $(shell sed 's/=.*//' .env)
endif

ifeq ($(UNAME),Darwin)
    OSX  := true
else
    LINUX  := true
endif

bootstrap:
	ssh root@$(APP_HOST) 'bash -s' < ./scripts/bootstrap.sh

provision:
	./scripts/provision.sh

setup:
ifdef $(foo)
	apt-get install ruby go ruby-bundle
endif 
	bundle
	go get -u github.com/tsenart/vegeta


test:
	env | sort

benchmark:
	./scripts/hello.sh

ssh:
	@echo "ssh root@$(APP_HOST)"