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

command: `make wrk_benchmark`
output: wrk_benchmark..txt

```
./scripts/hello.sh
Puma starting in single mode...
* Puma version: 5.3.2 (ruby 2.7.1-p83) ("Sweetnighter")
*  Min threads: 4
*  Max threads: 4
*  Environment: development
*          PID: 413416
* Listening on http://0.0.0.0:9292
Use Ctrl-C to stop
/usr/bin/ss
Running 30s test @ http://localhost:9292
  2 threads and 4 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     2.31ms    4.32ms  57.82ms   89.99%
    Req/Sec     2.46k   808.24     4.52k    66.61%
  Latency Distribution
     50%  623.00us
     75%    2.32ms
     90%    6.64ms
     99%   21.46ms
  146736 requests in 30.07s, 10.64MB read
Requests/sec:   4880.11
Transfer/sec:    362.20KB
- Gracefully stopping, waiting for requests to finish
```

### Benchmark App w Insturmentation

command: `make wrk_benchmark_insturmented`

```
./scripts/hello.sh
Puma starting in single mode...
* Puma version: 5.3.2 (ruby 2.7.1-p83) ("Sweetnighter")
*  Min threads: 4
*  Max threads: 4
*  Environment: development
*          PID: 416421
* Listening on http://0.0.0.0:9292
Use Ctrl-C to stop
/usr/bin/ss
Running 30s test @ http://localhost:9292
  2 threads and 4 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.94ms    3.36ms  41.78ms   90.58%
    Req/Sec     2.15k   531.56     3.52k    71.29%
  Latency Distribution
     50%  791.00us
     75%    1.90ms
     90%    5.06ms
     99%   17.32ms
  128691 requests in 30.08s, 9.33MB read
Requests/sec:   4278.15
Transfer/sec:    317.52KB
- Gracefully stopping, waiting for requests to finish
```

### Benchmark App wrk_benchmark_overload

command: `make wrk_benchmark_insturmented`

```
./scripts/hello.sh
Puma starting in single mode...
* Puma version: 5.3.2 (ruby 2.7.1-p83) ("Sweetnighter")
*  Min threads: 4
*  Max threads: 4
*  Environment: development
*          PID: 418831
* Listening on http://0.0.0.0:9292
Use Ctrl-C to stop
/usr/bin/ss
Running 30s test @ http://localhost:9292
  2 threads and 32 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    41.30ms   55.61ms 339.02ms   83.24%
    Req/Sec     1.48k   545.90     3.17k    68.62%
  Latency Distribution
     50%    5.98ms
     75%   73.20ms
     90%  123.50ms
     99%  218.48ms
  88379 requests in 30.09s, 6.52MB read
Requests/sec:   2937.14
Transfer/sec:    221.91KB
- Gracefully stopping, waiting for requests to finish
```

## 
