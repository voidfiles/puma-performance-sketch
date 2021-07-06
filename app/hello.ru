require 'datadog/statsd'

$statsd = Datadog::Statsd.new('localhost', 8125, :namespace => 'hello')

require_relative './rack_insturment'

LATENCIES = [
  0, 
  0.02, 0.02, 0.02, 0.02,
  0.05, 0.05, 0.05, 0.05, 0.05,
  0.07, 0.07,
  0.08,
  0.09,
  0.1
]

app = Rack::Builder.new do
  use Rack::Insturment if ENV["RACK_INSTURMENT"] == "true"
  run Proc.new { |env|
    sleep LATENCIES.sample if ENV["SLEEP_SOME"] == "true"
  
    [200, {"Content-Type" => "text/plain"}, ["Hello World"]]
  }
end

run app