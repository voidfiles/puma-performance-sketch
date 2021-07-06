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
	RACK_INSTURMENT=false PUMA_STATSD=false WRK_CONCURRENT=4 pipenv run ansible-playbook -i inventory playbooks/wrk_benchmark.yml

wrk_benchmark_insturmented:
	RACK_INSTURMENT=true PUMA_STATSD=false WRK_CONCURRENT=4 pipenv run ansible-playbook -i inventory playbooks/wrk_benchmark.yml

wrk_benchmark_overload:
	RACK_INSTURMENT=true PUMA_STATSD=false WRK_CONCURRENT=32 pipenv run ansible-playbook -i inventory playbooks/wrk_benchmark.yml

wrk_benchmark_overload_puma_stats:
	RACK_INSTURMENT=true PUMA_STATSD=true WRK_CONCURRENT=32 pipenv run ansible-playbook -i inventory playbooks/wrk_benchmark.yml

run:
	./scripts/run.sh

benchmark:
	./scripts/hello.sh

load:
	./scripts/load.sh