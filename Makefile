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
#	ssh root@$(APP_HOST) 'bash -s' < ./scripts/bootstrap.sh
	ssh root@$(BENCHMARK_HOST) 'bash -s' < ./scripts/bootstrap.sh

provision:
	./scripts/provision.sh

setup:
	cd app && bundle
	go get -u github.com/tsenart/vegeta


test:
	env | sort

benchmark:
	./scripts/hello.sh

ssh:
	@echo "app_host: ssh root@$(APP_HOST)"
	@echo "benchmark: ssh root@$(BENCHMARK_HOST)"

update:
	ssh root@$(APP_HOST) 'cd projects/puma-performance-sketch; git pull --ff-only'
	ssh root@$(BENCHMARK_HOST) 'cd projects/puma-performance-sketch; git pull --ff-only'