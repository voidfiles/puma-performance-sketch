ENV["STATSD_IMPLEMENTATION"] = ENV.fetch("STATSD_IMPLEMENTATION", "statsd")
ENV["STATSD_ENV"] = ENV.fetch("STATSD_ENV", "production")
ENV["STATSD_PREFIX"] = ENV.fetch("STATSD_PREFIX", "hello")

require 'statsd-instrument'

require_relative './rack_insturment'

app = Rack::Builder.new do
  use Rack::Insturment
  run Proc.new { |env| [200, {"Content-Type" => "text/plain"}, ["Hello World"]] }
end

run app