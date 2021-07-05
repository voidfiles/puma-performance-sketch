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
	ssh root@$(APP_HOST) 'DD_API_KEY=$(DD_API_KEY) bash -s' < ./scripts/bootstrap.sh
	ssh root@$(BENCHMARK_HOST) 'DD_API_KEY=$(DD_API_KEY) bash -s' < ./scripts/bootstrap.sh

provision:
	pipenv run ansible-playbook playbooks/provision.yml

setup:
	pipenv run ansible-playbook -i inventory playbooks/app_host.yml

# setup:
# 	cd app && bundle
# 	go get -u github.com/tsenart/vegeta
# 	pipenv install

test:
	env | sort

benchmark:
	./scripts/hello.sh

ssh:
	@echo "app_host: ssh root@$(APP_HOST)"
	@echo "benchmark: ssh root@$(BENCHMARK_HOST)"

update:
	pipenv run ansible-playbook -i inventory playbooks/update.yml

install_bpf:
	bash ./scripts/install_ebpf.sh