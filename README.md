# Puma Performance Sketches

I'm trying to understand what impacts the performance of puma the application server.

## Create .env

For this to work you'll need a .env file

```
DD_API_KEY={A datadog key}
DO_API_KEY={A digital ocean token}
SSH_PUBLIC_KEY={Your public key}
```

## Initial Setup

How to run this set of tools to replicate results

1. Make sure you have python 3 environment on your local box including pipenv, and a ruby env setup
1. `make install` - setups up your python environment
1. `make setup` - creates some instances in digital ocean
1. Create `inventory` file like inventoy.sample based on the provisioned boxes
1. `make provision`- Installs all the packages needed for those boxes, compiling bpf can take a long time
1. `make update` - This pulls down the code from this repository onto the two remote boxes

At this point you'll have two boxes you can ssh into, and you can run the sample application

## Testing

You're boxes will have there own IPs one for your app_host, and one for your benchmark_host.


### Benchmark App w/o Insturmentation

Puma 1 process 4 threads
Wrk 4 connections


