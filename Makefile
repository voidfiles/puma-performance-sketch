# Include local env vars
ifneq ("$(wildcard .env)","")
    include .env
	export $(shell sed 's/=.*//' .env)
endif

install:
	pipenv install
	(cd app && bundle)

provision:
	pipenv run ansible-playbook playbooks/provision.yml

setup:
	pipenv run ansible-playbook -i inventory playbooks/app_host.yml playbooks/benchmark_host.yml

update:
	pipenv run ansible-playbook -i inventory playbooks/update.yml

run:
	./scripts/run.sh

benchmark:
	./scripts/hello.sh

load:
	./scripts/load.sh