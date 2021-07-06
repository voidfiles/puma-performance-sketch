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

wrk_benchmark:
	RACK_INSTURMENT=false pipenv run ansible-playbook -i inventory playbooks/wrk_benchmark.yml

wrk_benchmark_insturmented:
	pipenv run ansible-playbook -i inventory playbooks/wrk_benchmark.yml

wrk_benchmark_overload:
	WRK_CONCURRENT=32 pipenv run ansible-playbook -i inventory playbooks/wrk_benchmark.yml

wrk_benchmark_overload_puma_stats:
	PUMA_STATSD=true WRK_CONCURRENT=32 DURATION=300 pipenv run ansible-playbook -i inventory playbooks/wrk_benchmark.yml

run:
	./scripts/run.sh

benchmark:
	./scripts/hello.sh

load:
	./scripts/load.sh