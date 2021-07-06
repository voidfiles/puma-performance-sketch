num_treads = ENV.fetch("PUMA_THREADS", "4").to_i

queue_requests ENV.fetch("PUMA_QUEUE_REQUESTS", "true") == "true"

threads num_treads, num_treads

plugin :statsd if ENV["PUMA_STATSD"] == "true"