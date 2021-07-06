num_treads = ENV.fetch("PUMA_THREADS", "4").to_i

threads num_treads, num_treads

plugin :statsd if ENV["PUMA_STATSD"] == "true"