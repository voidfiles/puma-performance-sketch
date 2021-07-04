require 'statsd'

$statsd = Statsd.new 'localhost', 8125

require_relative './rack_insturment'

app = Rack::Builder.new do
  use Rack::Insturment
  run Proc.new { |env| [200, {"Content-Type" => "text/plain"}, ["Hello World"]] }
end

run app